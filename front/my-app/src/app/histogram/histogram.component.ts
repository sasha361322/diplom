import {Component} from "@angular/core";
import {Histogram} from "./histogram";

@Component({
  selector: 'my-app',
  templateUrl: `./histogram.component.html`
})

export class HistogramComponent{
  histogram: Histogram;
}
