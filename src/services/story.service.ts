import * as inkjs from 'inkjs';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Subject } from 'rxjs/Subject';
import { Choice } from 'inkjs';
import { StoryPoint } from '../interfaces/story-point.interface';
import { StoryPointOptions } from '../interfaces/story-point-options.interface';
import { RsvpStatus } from '../interfaces/rsvp-status.interface';
import { StoryEventType } from '../enums/story-event-type.enum';
import { UserInteraction } from '../interfaces/user-interaction.interface';
import { UserInteractionType } from '../enums/choice-type.enum';
import { StoryPointCommand } from '../enums/story-point-command.enum';
import { StoryPointSender } from '../enums/story-point-sender.enum';
import { UserInteractionHandlerService } from './user-interaction-handler.service';
import { UserInteractionValidatorService } from './user-interaction-validator.service';
import { Howl, Howler } from 'howler';
import { Rsvp } from 'src/interfaces/rsvp.interface';
import { Observable } from 'rxjs/Observable';
import * as moment from 'moment'
const uuidv4 = require('uuid/v4');

@Injectable()
export class StoryService {
  public currentUserInteraction: UserInteraction;
  public events: Subject<any>;
  public story: any;
  public storyPoints: StoryPoint[];
  public choiceEntries: Choice[];
  public rsvpSent: Rsvp;
  public mailtoWithParams: string;
  private userInteractSound: Howl;
  private dialogSound: Howl;
  private swooshSound: Howl;
  private songOutdoor: Howl;
  private songEntry: Howl;
  private songCeremony: Howl;
  private songDance: Howl;
  private songPartyAmbience: Howl;
  private currentSong: Howl;
  private isAutoChoose: boolean;
  private replayChoiceIndex: number;
  private rsvpApiUrl: string;
  private currentSessionId: string;
  private statusClicked = 'Clicked ';
  private statusEnteredName = 'Entered Name';
  private statusGameOver = 'Game Over';
  private statusSubmittedRSVP = 'Submitted RSVP';
  private rsvpApiEncounteredError: boolean;
  private startTime: any;

  constructor(
    private userInteractionHandlerService: UserInteractionHandlerService,
    private userInteractionValidatorService: UserInteractionValidatorService,
    private http: HttpClient
  ) {
    this.rsvpApiUrl = 'https://9qsuphdvvl.execute-api.ap-southeast-2.amazonaws.com/Prod/';
    this.events = new Subject();
    this.story = new inkjs.Story(require('../ink/Wedding.ink.json'));
    this.storyPoints = [];
    this.choiceEntries = [];

    this.userInteractionHandlerService.init(this.story);

    this.userInteractSound = new Howl({ src: ['./assets/sounds/button-4.mp3'], volume: 0.7 }); // https://danielstern.github.io/ngAudio/#/
    this.dialogSound = new Howl({ src: ['./assets/sounds/button-1.mp3'], volume: 0.3 });
    this.swooshSound = new Howl({ src: ['./assets/sounds/swoosh.mp3'], volume: 0.3 }); // http://soundbible.com/670-Swooshing.html
    // https://freesound.org/people/blouhond/sounds/157947/
    this.songOutdoor = new Howl({ src: ['./assets/sounds/outdoorAmbience.mp3'], volume: 1, loop: true });
    // https://www.liberliber.it/online/autori/autori-c/petr-ilic-cajkovskij/lo-schiaccianoci-scelkuncik-op-71/
    this.songEntry = new Howl({ src: ['./assets/sounds/WaltzOfFlowersTrimFade.mp3'], volume: 0.5, loop: true});
    // Pachelbel Canon in D http://www.gyrosquartet.com/audio/Pachelbel.mp3
    this.songCeremony = new Howl({ src: ['./assets/sounds/Pachelbel.mp3'], volume: 0.5, loop: true});
    // https://www.youtube.com/watch?v=P-QY1OF2x2E Haddaway - What is Love Original Instrumental
    this.songDance = new Howl({ src: ['./assets/sounds/whatislove.mp3'], volume: 0.5, loop: true });
    // http://soundbible.com/2163-Party-Crowd.html
    this.songPartyAmbience = new Howl({ src: ['./assets/sounds/partycrowd.mp3'], volume: 0.2, loop: true });

    Howler.volume(1);
  }

  public start() {
    this.currentSessionId = uuidv4();
    this.proceed();
    this.startTime = moment();
  }

  public back() {
    if (this.currentSong) {
      this.currentSong.stop();
      this.currentSong = undefined as Howl;
    }
    this.choicesTrimBackToLastMulti();
    this.replayChoiceIndex = 0;
    // Reset, then proceed with isAutoChoose on.
    this.events.next({
      type: StoryEventType.RESET
    });
    this.story.ResetState();
    this.storyPoints = [];
    this.isAutoChoose = true;
    this.proceed();
  }

  choicesTrimBackToLastMulti() {
    let indexOfLastMultiOrEntry = 0;
    for (let index = this.choiceEntries.length - 1; index > 1; index--) {
      const element = this.choiceEntries[index];
      if (!element.isSingleOption || element.isTextEntry) {
        indexOfLastMultiOrEntry = index;
        break;
      }
    }
    this.choiceEntries.splice(indexOfLastMultiOrEntry, this.choiceEntries.length - indexOfLastMultiOrEntry);
  }

  public reset() {
    if (this.currentSong) {
      this.currentSong.stop();
      this.currentSong = undefined as Howl;
    }
    this.startTime = moment();
    this.currentSessionId = uuidv4();
    this.currentUserInteraction = {};
    this.events.next({
      type: StoryEventType.RESET
    });
    this.story.ResetState();
    this.story.variablesState._globalVariables.set('backUnlocked', '1');
    this.storyPoints = [];
    this.choiceEntries = [];
    this.proceed();
  }

  public triggerUserInteraction(value: Choice | string) {
    if (typeof value === 'string') {
      this.validateAndSetStateForStringChoice(value);
      this.story.ChooseChoiceIndex(0);
      this.choiceEntries.push({ index: 0, text: value, isTextEntry: true, isSingleOption: true });
    } else {
      if (this.choiceEntries.length === 0) {
        this.sendRSVPStatus(this.statusClicked + value.text);
      }
      this.story.ChooseChoiceIndex(value.index);
      this.choiceEntries.push(value);
    }
    this.events.next({
      type: StoryEventType.USER_INTERACTION_FINISHED,
      data: this.currentUserInteraction
    });
    this.currentUserInteraction = null;
    this.proceed();
  }

  public toggleIsMuted(): boolean {
    const newVolume = Howler.volume() === 1 ? 0 : 1;
    Howler.volume(newVolume);
    return newVolume !== 1;
  }

  private proceed() {
    if (this.story) {
      if (this.story.canContinue) {
        const storyMessage = this.story.Continue();
        this.log(storyMessage);
        const storyPoint = this.buildStoryPointFromMessage(storyMessage);

        // if (storyPoint.options.cmd === StoryPointCommand.BACK_UNLOCK) {
          this.events.next({
            type: StoryEventType.BACK_UNLOCK
          });
        // }

        this.playSongOnRepeat(storyPoint.options.cmd)
        if (storyPoint.options.cmd === StoryPointCommand.GAME_OVER) {
          this.sendRSVPStatus(this.statusGameOver);
        }
        if (storyPoint.options.cmd === StoryPointCommand.SUBMIT_RSVP) {
          this.sendRSVP();
          this.sendRSVPStatus(this.statusSubmittedRSVP);
          if (this.rsvpApiEncounteredError) {
            // if sendRSVPStatus Failed, assume we can't connect to lambda, so just mailto instead.
            this.setSendEmailInteraction();
            return;
          }
        }

        if (storyPoint.options.cmd === StoryPointCommand.RESET) {
          this.reset();
        } else {
          const delay = this.isAutoChoose ? 0 : storyPoint.options.delay;
          setTimeout(() => {
            if (!this.isAutoChoose) {
              if (storyPoint.options.sender === StoryPointSender.DIALOG) {
                this.dialogSound.play();
              } else if (storyPoint.options.sender === StoryPointSender.USER) {
                this.userInteractSound.play();
              } else {
                this.swooshSound.play();
              }
            }
            this.storyPoints.push(storyPoint);
            this.events.next({
              type: StoryEventType.STORY_POINT_ADDED,
              data: storyPoint
            });
            this.proceed();
          }, delay);
        }
      } else if (this.story.currentChoices.length > 0) {
        this.currentUserInteraction = this.buildUserInteractionFromChoices(this.story.currentChoices);
        if (this.replayChoiceIndex > this.choiceEntries.length - 1) {
          this.isAutoChoose = false;
        }
        if (this.isAutoChoose) {
          const choicePreviouslyMade = this.choiceEntries[this.replayChoiceIndex];
          this.replayChoiceIndex++;
          if (choicePreviouslyMade.isTextEntry) { this.validateAndSetStateForStringChoice(choicePreviouslyMade.text); }
          this.story.ChooseChoiceIndex(choicePreviouslyMade.index);
          this.currentUserInteraction = {};
          this.proceed();
        } else {
          this.events.next({
            type: StoryEventType.USER_INTERACTION_STARTED,
            data: this.currentUserInteraction
          });
        }
      }
    }
  }
  playSongOnRepeat(cmd: StoryPointCommand) {
    if (cmd === StoryPointCommand.SONG_OUTDOOR) {
      this.playNextFadeOutPrevious(this.songOutdoor, 1.0);
    } else if (cmd === StoryPointCommand.SONG_ENTRY) {
      this.playNextFadeOutPrevious(this.songEntry, 0.5);
    } else if (cmd === StoryPointCommand.SONG_CEREMONY) {
      this.playNextFadeOutPrevious(this.songCeremony, 0.5);
    } else if (cmd === StoryPointCommand.SONG_DANCE) {
      this.playNextFadeOutPrevious(this.songDance, 0.5);
    } else if (cmd === StoryPointCommand.SONG_PARTYAMBIENCE) {
      this.playNextFadeOutPrevious(this.songPartyAmbience, 0.2);
    }
  }

  playNextFadeOutPrevious(newTrack: Howl, newTrackVol: number) {
    if (this.currentSong !== undefined) {
      this.currentSong.once( 'fade', () => {
        this.currentSong.stop(); });
      this.currentSong.fade(this.currentSong.volume(), 0, 1000);
    }
    newTrack.once( 'fade', () => {
      this.currentSong = newTrack;
    });
    newTrack.fade(0, newTrackVol, 2000);
    newTrack.play();
  }

  setSendEmailInteraction() {
    this.buildMailToParams();
    const sorryMsg = `Terribly sorry, but it looks like I\'m having trouble saving your RSVP.
            Please send your RSVP to jessewedlillian@gmail.com or click the button below.`;
    const extraStoryPoint = {
      // tslint:disable-next-line: max-line-length
      displayMessage: sorryMsg,
      originalMessage: sorryMsg,
      options: this.buildStoryPointOptionsFromTag('{ "sender": 1 }')
    }
    this.storyPoints.push(extraStoryPoint);
    this.events.next({
      type: StoryEventType.STORY_POINT_ADDED,
      data: extraStoryPoint
    });

    this.currentUserInteraction = { type: UserInteractionType.MAILTO }
    this.events.next({
      type: StoryEventType.USER_INTERACTION_STARTED,
      data: this.currentUserInteraction
    });
  }

  buildMailToParams() {
    let subject = `${this.rsvpSent.Name}`;
    if (this.rsvpSent.IsAttending) {
      subject += ' is attending!';
    } else {
      subject += ' cannot attend.';
    }
    let body = `Hello guys,\n`;
    body += `It's me: ${this.rsvpSent.Name}\n`;
    if (this.rsvpSent.IsAttending) {
      body += 'I am attending!\n';
    } else {
      body += 'Unfortunately, I cannot attend.\n';
    }
    if (this.rsvpSent.OtherNames !== '') {
      body += `I\m responding on behalf of: ${this.rsvpSent.OtherNames}.\n`;
    }
    if (this.rsvpSent.DietaryRequirements !== '') {
      body += `These are the dietary requirements: ${this.rsvpSent.DietaryRequirements}.\n`;
    }
    if (this.rsvpSent.Comments !== '') {
      body += `I wanted to comment: ${this.rsvpSent.Comments}.\n`;
    }
    if (this.rsvpSent.EmailOrPhone !== '') {
      body += `You can contact me at: ${this.rsvpSent.EmailOrPhone}.\n`;
    }
    body += `Kind regards, ${this.rsvpSent.Name}.\n`;

    this.mailtoWithParams = `mailto:jessewedlillian@gmail.com
?subject=${encodeURIComponent(subject)}
&body=${encodeURIComponent(body)}`;
  }

  sendRSVPStatus(status: string) {
    let name = this.getGlobalVar('name').toString();
    if (name === '') { name = 'No name yet'; }
    const PlayTime = moment().diff(this.startTime);
    const ChoicesMadeCount = this.choiceEntries.length;

    const rsvpstatus: RsvpStatus = { Name: name, Status: status, SessionId: this.currentSessionId, PlayTime, ChoicesMadeCount };
    this.http.post(this.rsvpApiUrl + 'rsvpstatus', rsvpstatus, { responseType: 'text' }).subscribe(
      (data: any) => this.log('POST RSVP Status ' + data),
      error => { this.rsvpApiEncounteredError = true; console.log('Error in POST RSVP Status: ' + JSON.stringify(error)); }
    );
  }

  sendRSVP() {
    let Name = this.getGlobalVar('name').toString();
    if (Name === '') { Name = 'No name yet'; }
    const IsAttending = this.getGlobalVar('isAttending') === 1;
    const OtherNames = this.getGlobalVar('otherNames').toString();
    const EmailOrPhone = this.getGlobalVar('emailOrPhone').toString();
    const Comments = this.getGlobalVar('comments').toString();
    const DietaryRequirements = this.getGlobalVar('diet').toString();
    const PlayTime = moment().diff(this.startTime);
    const ChoicesMadeCount = this.choiceEntries.length;

    this.rsvpSent = {
      Name, SessionId: this.currentSessionId, IsAttending,
      OtherNames, EmailOrPhone, DietaryRequirements, Comments, PlayTime, ChoicesMadeCount
    };
    this.http.post(this.rsvpApiUrl + 'rsvp', this.rsvpSent, { responseType: 'text' }).subscribe(
      (data: any) => this.log('POST RSVP ' + data),
      error => { this.rsvpApiEncounteredError = true; console.log('Error in POST RSVP ' + JSON.stringify(error)); }
    );
  }

  private getGlobalVar(varName: string): string | number {
    let value = '';
    if (this.story.variablesState.GlobalVariableExistsWithName(varName)) {
      value = this.story.variablesState._globalVariables.get(varName).value;
    }
    return value;
  }

  private validateAndSetStateForStringChoice(value: string) {
    if (this.currentUserInteraction.validator) {
      const validationError = this.userInteractionValidatorService.validate(this.currentUserInteraction.validator, value);
      this.story.variablesState.$('validationError', validationError || '');
    }
    if (this.currentUserInteraction.handler) {
      this.userInteractionHandlerService.handle(this.currentUserInteraction.handler, value);
    }

    if (this.currentUserInteraction.stateVar) {
      this.story.variablesState.$(this.currentUserInteraction.stateVar, value);
      if (this.currentUserInteraction.stateVar === 'nameEntry') {
        this.sendRSVPStatus(this.statusEnteredName);
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
    const isSingleOption = choices.length === 1;
    choices = choices.map(c => {
      return {
        index: c.index,
        text: c.text,
        isTextEntry: c.isTextEntry,
        isSingleOption,
      };
    });

    return Object.assign({
      choices: choices,
      type: UserInteractionType.DEFAULT
    }, currentTag.userInteraction || {});
  }

  log(log: string) {
    if (!process.env.production) {
      console.log(log);
    }
  }
}
