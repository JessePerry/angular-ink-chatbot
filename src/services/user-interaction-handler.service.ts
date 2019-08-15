import * as moment from 'moment';

import { Injectable } from '@angular/core';

@Injectable()
export class UserInteractionHandlerService {
  private story: any;

  constructor() {}

  public init(story: any) {
    this.story = story;
  }

  public handle(handler: string, value: string) {
    if (typeof this[handler] === 'function') {
      this[handler](value);
    }
  }

  private birthdayToAge(value: string) {
    this.story.variablesState.$('age', String(moment().diff(moment(value, 'MM/DD/YYYY'), 'years')));
  }

  private nameHandler(value: string) {
    if (value === '') {
      return
    }
    value = value.replace(/[^\w\s]/gi, '').substring(0, 200);
    let capitalName = '';
    value.split(' ').forEach(namePart => {
      capitalName += namePart.charAt(0).toUpperCase() + namePart.slice(1).toLowerCase() + ' ';
    });
    capitalName = capitalName.trim();
    let firstChar = capitalName.toLowerCase()[0];
    if (firstChar === 'a') {
      firstChar = 'z'
    } else {
      firstChar = String.fromCharCode(firstChar.charCodeAt(0) - 1);
    }
    const nameLowerAlpha = firstChar.toUpperCase() + capitalName.slice(1);

    console.log(`nameHandler name: ${value} into ${capitalName} and nameLowerAlpha ${nameLowerAlpha}`);
    this.story.variablesState.$('name', capitalName);
    this.story.variablesState.$('nameLowerAlpha', nameLowerAlpha);
  }
}
