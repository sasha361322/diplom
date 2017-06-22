import {Component, OnInit} from "@angular/core";
import {Histogram} from "./histogram";
import {ActivatedRoute, Router} from "@angular/router";
import {Data} from "../data";
import {Column} from "../columns/column";
import {BarchartComponent} from "./barchart.component";

@Component({
  selector: 'my-app',
  templateUrl: `./histogram.component.html`
})

export class HistogramComponent implements OnInit{
  histogram: Histogram;
  chartData: Array<any>;

  constructor(private router: Router, private data: Data) {
  }

  backToColumns():void{
    this.router.navigate(['/tableDetails']);
  }
  backToConnections():void{
    this.router.navigate(['/connections']);
  }

  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    if(!this.data.column)
      this.router.navigate(['/connections']);
    let column:Column = JSON.parse(this.data.column);
    this.histogram = column.histogram;
    this.generateData();
  }

  generateData() {
    this.chartData = [];
    if (this.histogram.step == null){
      let count:number = JSON.parse(this.data.column).countDistinctValues;
      for (let i = 0; i < count; i++){
        this.chartData.push([
          `${this.histogram.middleOfIntervals[i]}`,
          this.histogram.frequencies[i]
        ]);
      }
    } else {
      let min = this.histogram.min;
      for (let i = 0; i < this.histogram.stepCount - 1; i++) {
        this.chartData.push([
          `[${min}-${min+this.histogram.step}]`,
          this.histogram.frequencies[i]
        ]);
        min += this.histogram.step;
      }
      this.chartData.push([
        `[${min}-${this.histogram.max}]`,
        this.histogram.frequencies[this.histogram.stepCount - 1]
      ]);
    }
  }
}
