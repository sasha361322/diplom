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
  column:Column;

  constructor(private router: Router, private data: Data) {
  }

  ngOnInit(): void {
    this.column = JSON.parse(this.data.column);
    console.log(this.column);
    this.histogram = this.column.histogram;
  }
}
