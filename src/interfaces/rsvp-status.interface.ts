import { Duration } from 'moment';

export interface RsvpStatus {
  SessionId: string,
  Name: string,
  AtTime?: string,
  Status: string,
  PlayTime?: number;
  ChoicesMadeCount?: number;
}
