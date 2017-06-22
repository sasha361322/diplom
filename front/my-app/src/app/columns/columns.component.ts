import {Component, OnInit} from "@angular/core";
import {Column} from "./column";
import {Router} from "@angular/router";
import {Table} from "../tables/table";
import {Data} from "../data";

@Component({
  selector: 'columns-selector',
  templateUrl: `./columns.component.html`,
})

export class ColumnsComponent implements OnInit{
  table:Table;
  columns: Column[];
  tableName: string;

  constructor(private router: Router, private data: Data) {
  }

  ngOnInit(): void {
    this.table = JSON.parse(this.data.table);
    console.log(this.table);
    this.columns = this.table.columns;
    this.tableName = this.table.name;
  }

  showStatistics(column: Column): void {
    console.log("column"+column);
    this.data.column = JSON.stringify(column);
    this.router.navigate(['/statistics']);
  }

}
