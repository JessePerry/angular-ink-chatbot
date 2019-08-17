import * as moment from 'moment';

import { Injectable } from '@angular/core';

@Injectable()
export class UserInteractionHandlerService {
  private story: any;

  constructor() { }

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
    const firstChar = this.getAppropriateEarlierAlphaLetter(capitalName.toLowerCase()[0]);
    // console.log(`${firstChar} + ${capitalName.charAt(0).toLowerCase()} + ${capitalName.slice(1)}`)
    let nameLowerAlpha = ''
    if (firstChar === 'a') {
      nameLowerAlpha = 'A' + capitalName.charAt(0).toLowerCase() + capitalName.slice(1);
    } else {
      nameLowerAlpha = firstChar.toUpperCase() + capitalName.slice(1);
    }

    // console.log(`nameHandler name: ${value} into ${capitalName} and nameLowerAlpha ${nameLowerAlpha}`);
    this.story.variablesState.$('name', capitalName);
    this.story.variablesState.$('nameLowerAlpha', nameLowerAlpha);
  }

  private otherNamesHandler(value: string) {
    this.story.variablesState.$('otherNames', value);
  }

  private emailOrPhoneHandler(value: string) {
    this.story.variablesState.$('emailOrPhone', value);
  }

  private commentsHandler(value: string) {
    this.story.variablesState.$('comments', value);
  }

  private getAppropriateEarlierAlphaLetter(letter: string): string {
    if (letter === 'a') { return letter; } // Don't loop to z. Eg: Aaron would be Aaaron
    const acceptableLetters = /[abcdfghjkmnpqrstvqxyz]/g // Don't use vowels or I or L because of font readability
    letter = String.fromCharCode(letter.charCodeAt(0) - 1);
    if (letter.match(acceptableLetters) === null) {
      letter = this.getAppropriateEarlierAlphaLetter(letter)
    }
    return letter;
  }
}
