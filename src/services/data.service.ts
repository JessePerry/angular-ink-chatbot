import { Injectable } from '@angular/core';
import { StoryService } from '../services/story.service';

@Injectable()
export class DataService {
  constructor(private storyService: StoryService) {
  }

}
