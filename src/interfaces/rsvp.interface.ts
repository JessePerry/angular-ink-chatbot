import { Duration } from 'moment';

export interface Rsvp {
  SessionId: string,
  Name: string,
  AtTime?: string,
  IsAttending?: boolean;
  OtherNames?: string;
  DietaryRequirements?: string;
  EmailOrPhone?: string;
  Comments?: string;
  PlayTime?: number;
  ChoicesMadeCount?: number;
}
