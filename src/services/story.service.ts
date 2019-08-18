import * as inkjs from 'inkjs';

import { Injectable } from '@angular/core';
import { Subject } from 'rxjs/Subject';
import { Choice } from 'inkjs';
import { StoryPoint } from '../interfaces/story-point.interface';
import { StoryPointOptions } from '../interfaces/story-point-options.interface';
import { StoryEventType } from '../enums/story-event-type.enum';
import { UserInteraction } from '../interfaces/user-interaction.interface';
import { UserInteractionType } from '../enums/choice-type.enum';
import { StoryPointCommand } from '../enums/story-point-command.enum';
import { StoryPointSender } from '../enums/story-point-sender.enum';
import { UserInteractionHandlerService } from './user-interaction-handler.service';
import { UserInteractionValidatorService } from './user-interaction-validator.service';
import { JsonPipe } from '@angular/common';
import { SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION } from 'constants';

@Injectable()
export class StoryService {
  private paused = false;

  public currentUserInteraction: UserInteraction;
  public events: Subject<any>;
  public story: any;
  public storyPoints: StoryPoint[];
  public choiceEntries: string[]

  constructor(
    private userInteractionHandlerService: UserInteractionHandlerService,
    private userInteractionValidatorService: UserInteractionValidatorService
  ) {
    this.events = new Subject();
    this.story = new inkjs.Story(require('../ink/Wedding.ink.json'));
    this.storyPoints = [];
    this.choiceEntries = [];

    this.userInteractionHandlerService.init(this.story);
  }

  public start() {
    this.paused = false;
    this.proceed();
  }

  public pause() {
    this.paused = true;
  }

  public triggerUserInteraction(value: Choice | string) {
    if (typeof value === 'string') {
      if (this.currentUserInteraction.validator) {
        const validationError = this.userInteractionValidatorService.validate(this.currentUserInteraction.validator, value);
        this.story.variablesState.$('validationError', validationError || '');
      }

      if (this.currentUserInteraction.handler) {
        this.userInteractionHandlerService.handle(this.currentUserInteraction.handler, value);
      }

      if (this.currentUserInteraction.stateVar) {
        this.story.variablesState.$(this.currentUserInteraction.stateVar, value);
      }
      this.story.ChooseChoiceIndex(0);
      this.choiceEntries.push(value);
    } else {
      this.story.ChooseChoiceIndex(value.index);
      this.choiceEntries.push(value.text);
    }

    // console.log(`Story Points: ${JSON.stringify(this.storyPoints.map((p) => p.originalMessage))}`);
    console.log(`Choice Entries: ${JSON.stringify(this.choiceEntries)}`);
    this.events.next({
      type: StoryEventType.USER_INTERACTION_FINISHED,
      data: this.currentUserInteraction
    });
    this.currentUserInteraction = null;
    this.proceed();
  }

  private proceed() {
    if (!this.paused && this.story) {
      if (this.story.canContinue) {
        const storyMessage = this.story.Continue();
        console.log(storyMessage);
        const storyPoint = this.buildStoryPointFromMessage(storyMessage);

        if (storyPoint.options.cmd === StoryPointCommand.RESET) {
          this.events.next({
            type: StoryEventType.RESET
          });
          this.story.ResetState();
          this.storyPoints = [];
          this.choiceEntries = [];
          this.paused = false;
          this.proceed();
        } else {
          setTimeout(() => {
            this.storyPoints.push(storyPoint);
            this.events.next({
              type: StoryEventType.STORY_POINT_ADDED,
              data: storyPoint
            });
            this.proceed();
          }, storyPoint.options.delay);
        }
      } else if (this.story.currentChoices.length > 0) {
        this.currentUserInteraction = this.buildUserInteractionFromChoices(this.story.currentChoices);
        this.events.next({
          type: StoryEventType.USER_INTERACTION_STARTED,
          data: this.currentUserInteraction
        });
      }
    }
  }

  private buildStoryPointFromMessage(message: string): StoryPoint {
    const currentTag = this.story.currentTags.length > 0 ? this.story.currentTags[0] : '{}';

    return {
      displayMessage: message,
      originalMessage: message,
      options: this.buildStoryPointOptionsFromTag(currentTag)
    }
  }

  private buildStoryPointOptionsFromTag(tag: string): StoryPointOptions {
    const customOptions: StoryPointOptions = JSON.parse(tag);
    if (customOptions.cmd === StoryPointCommand.RESET) {
      return customOptions;
    }
    return Object.assign({
      delay: (customOptions.sender === StoryPointSender.USER) ? 0 : 500, // 1500,
      sender: customOptions.sender,
    }, customOptions);
  }

  private buildUserInteractionFromChoices(choices: Choice[]): UserInteraction {
    const currentTag = this.story.currentTags.length > 0 ? JSON.parse(this.story.currentTags[0]) : {};

    choices = choices.map(c => {
      return {
        index: c.index,
        text: c.text
      };
    });

    return Object.assign({
      choices: choices,
      type: UserInteractionType.DEFAULT
    }, currentTag.userInteraction || {});
  }
}
