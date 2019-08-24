import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { StoryService } from '../../services/story.service';
import { StoryPoint } from '../../interfaces/story-point.interface';
import { UserInteraction } from '../../interfaces/user-interaction.interface';
import * as animejs from 'animejs';
import { StoryEventType } from '../../enums/story-event-type.enum';
import { faUndo, IconDefinition, faVolumeUp, faVolumeOff } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'bot-message-panel',
  templateUrl: './message-panel.component.html'
})
export class MessagePanelComponent implements OnInit {
  faUndo: IconDefinition = faUndo
  faVolumeOffOrUp: IconDefinition = faVolumeUp
  showBackButton = false;
  @ViewChild('avatar') private avatarElementRef: ElementRef;
  @ViewChild('header') private headerElementRef: ElementRef;
  private scrolled = false;
  constructor(private storyService: StoryService) {
    this.storyService.events.subscribe(x => {
      if (x.type === StoryEventType.RESET) {
        this.animateAvatarBig();
      } else if (x.type === StoryEventType.BACK_UNLOCK) {
        this.showBackButton = true;
      }
    })
  }

  public ngOnInit() {
    // First we get the viewport height and we multiple it by 1% to get a value for a vh unit
    const vh = window.innerHeight * 0.01;
    // Then we set the value in the --vh custom property to the root of the document
    document.documentElement.style.setProperty('--vh', `${vh}px`);
  }

  public storyBack() {
    this.storyService.back();
  }

  public storyReset() {
    this.storyService.reset();
  }

  public onScroll(event: any) {
    if (!this.scrolled) {
      this.animateAvatarSmall();
      this.scrolled = true;
    }
  }

  public toggleMute() {
    this.faVolumeOffOrUp = this.storyService.toggleIsMuted() ? faVolumeOff : faVolumeUp;
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
    // animejs({
    //   targets: this.avatar,
    //   width: ['100%', '40%'],
    //   duration: 500,
    //   easing: 'easeOutSine'
    // });
    animejs({
      targets: this.headerElementRef.nativeElement,
      height: ['200px', '100px'],
      duration: 500,
      easing: 'easeOutSine'
    });
  }

  private async animateAvatarBig() {
    animejs({
      targets: this.headerElementRef.nativeElement,
      height: ['100px', '200px'],
      duration: 500,
      easing: 'easeOutSine'
    });
    // await animejs({
    //   targets: this.avatar,
    //   width: ['40%', '100%'],
    //   duration: 500,
    //   easing: 'easeOutSine'
    // }).finished;
    this.scrolled = false;
  }
}
