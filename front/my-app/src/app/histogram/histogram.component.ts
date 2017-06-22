import {Component, OnInit} from "@angular/core";
import {Histogram} from "./histogram";
import {ActivatedRoute, Router} from "@angular/router";
import {Data} from "../data";
import {Column} from "../columns/column";

@Component({
  selector: 'my-app',
  templateUrl: `./histogram.component.html`
})

export class HistogramComponent implements OnInit{
  histogram: Histogram;

  constructor(private router: Router, private data: Data) {
  }

  ngOnInit(): void {
    let column:Column = JSON.parse(this.data.column);
    this.histogram = column.histogram;
  }
}
