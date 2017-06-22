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
  columns: Column[];
  tableName: string;

  constructor(private router: Router, private data: Data) { }

  ngOnInit(): void {
    let table:Table= JSON.parse(this.data.table);
    this.columns = table.columns;
    this.tableName = table.name;
  }

  showStatistics(column: Column): void {
    console.log("column"+column);
    this.data.column = JSON.stringify(column);
    this.router.navigate(['/statistics']);
  }

}
