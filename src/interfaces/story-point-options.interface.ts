import { StoryPointSender } from '../enums/story-point-sender.enum';
import { StoryPointCommand } from '../enums/story-point-command.enum';

export interface StoryPointOptions {
  delay?: number;
  sender?: StoryPointSender;
  cmd?: StoryPointCommand;
}
