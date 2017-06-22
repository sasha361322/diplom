import {Component, NgModule, Input, Output, OnInit} from "@angular/core";
import {Table} from "./table";
import {Router, NavigationExtras} from "@angular/router";
import {Column} from "../columns/column";
import {Data} from "../data";
import {Histogram} from "../histogram/histogram";


@Component({
  selector: 'tables-selector',
  templateUrl: `./tables.component.html`
})

export class TablesComponent implements OnInit{
  tables: Table[];

  ngOnInit(): void {
    this.getTables();
  }

  constructor(private router: Router, private data: Data) {
  }

  showColumns(table: Table): void {
    this.data.tables = JSON.stringify(this.tables);
    this.data.table = JSON.stringify(table);
    this.router.navigate(["/tableDetails"]);
  }

  getTables(): void{
    //get data from rest
    this.tables = [new Table("qwe", 5, 123, []), new Table("qwe1", 12, 111, [])];
    this.tables[0].columns.push(new Column("qwe"));
    this.tables[0].columns.push(new Column("qwert"));
    this.tables[1].columns.push(new Column("qwe1"));
    this.tables[0].columns[0].histogram = new Histogram();
    this.tables[0].columns[1].histogram = new Histogram();
    this.tables[1].columns[0].histogram = new Histogram();
  }

  getXml():void{
    //  /download GET
    this.router.navigate(['/connections']);
  }
}


