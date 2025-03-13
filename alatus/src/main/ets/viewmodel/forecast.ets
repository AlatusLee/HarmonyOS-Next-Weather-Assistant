import { cast } from './cast';

export class forecast {
  city: string;
  adcode: number;
  casts: Array<cast>;
  constructor(city: string, adcode: number, casts: Array<cast>) {
    this.city = city;
    this.adcode = adcode;
    this.casts = casts;
  }
}