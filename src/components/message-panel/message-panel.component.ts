import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { StoryService } from '../../services/story.service';
import { StoryPoint } from '../../interfaces/story-point.interface';
import { UserInteraction } from '../../interfaces/user-interaction.interface';
import * as animejs from 'animejs';
import { StoryEventType } from '../../enums/story-event-type.enum';

@Component({
  selector: 'bot-message-panel',
  templateUrl: './message-panel.component.html'
})
export class MessagePanelComponent implements OnInit {
  @ViewChild('avatar') private avatarElementRef: ElementRef;
  private scrolled = false;

  constructor(private storyService: StoryService) {
    this.storyService.events.subscribe(x => {
      if (x.type === StoryEventType.RESET) {
        this.animateAvatarBig();
      }
    })
  }

  public ngOnInit() { }

  public onScroll(event: any) {
    if (!this.scrolled) {
      this.animateAvatarSmall();
      this.scrolled = true;
    }
  }

  get currentUserInteraction(): UserInteraction {
    return this.storyService.currentUserInteraction;
  }

  get storyPoints(): StoryPoint[] {
    return this.storyService.storyPoints;
  }

  get avatar(): HTMLElement {
    return this.avatarElementRef.nativeElement;
  }

  private animateAvatarSmall() {
    animejs({
      targets: this.avatar,
      width: [200, 100],
      duration: 2000,
      elasticity: 0,
    });
  }

  private async animateAvatarBig() {
    await animejs({
      targets: this.avatar,
      width: [100, 200],
      duration: 2000,
      elasticity: 0
    }).finished;
    this.scrolled = false;
  }
}
