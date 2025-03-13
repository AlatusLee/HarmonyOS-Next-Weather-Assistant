import { forecast } from './forecast';

export class weatherModel {
  status: string;
  count: number;
  infocode: number;
  forecasts: Array<forecast> = [];

  constructor(status: string, count: number, infocode: number, forecasts: Array<forecast>) {
    this.status = status;
    this.count = count;
    this.infocode = infocode;
    this.forecasts = forecasts;
  }
}