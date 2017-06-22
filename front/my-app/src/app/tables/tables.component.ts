import {Component, NgModule, Input, Output, OnInit} from "@angular/core";
import {Table} from "./table";
import {Router, NavigationExtras} from "@angular/router";
import {Column} from "../columns/column";
import {Data} from "../data";


@Component({
  selector: 'tables-selector',
  templateUrl: `./tables.component.html`
})

export class TablesComponent implements OnInit{
  tables: Table[];

  ngOnInit(): void {
    throw new Error("Method not implemented.");
  }

  constructor(private router: Router, private data: Data) {
    this.getTables();
  }

  showColumns(table: Table): void {
    this.data.storage = JSON.stringify(table.columns);
    this.router.navigate(["/tableDetails"]);
  }

  getTables(): void{
    //get data from rest
    this.tables = [new Table("qwe", 5, 123, [])];
    this.tables[0].columns.push(new Column("qwe"));
  }

  getXml():void{
    //  /download GET
    this.router.navigate(['/connections']);
  }
}


