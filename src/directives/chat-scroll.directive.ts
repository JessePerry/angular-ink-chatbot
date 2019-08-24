import { Directive, ElementRef, OnInit } from '@angular/core';
import * as anime from 'animejs';

@Directive({
  selector: '[botChatScroll]'
})
export class ChatScrollDirective implements OnInit {
  constructor(private elementRef: ElementRef) { }

  public ngOnInit() {
    this.scrollToBottom();

    (new MutationObserver(() => {
      this.scrollToBottom();
    })).observe(this.elementRef.nativeElement, { childList: true, subtree: true });
  }

  private scrollToBottom() {
    setTimeout(() => {
      this.elementRef.nativeElement.scroll({
        top: this.elementRef.nativeElement.scrollHeight,
        left: 0,
        behavior: 'smooth'
      });
    }, 25); // A 5ms delay gives images or tall content a chance to load to scroll correctly
  }
}
