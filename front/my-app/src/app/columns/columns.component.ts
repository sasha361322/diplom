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
  token:any;
  tableName: string;

  constructor(private router: Router, private data: Data) { }

  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.token=localStorage.getItem("token");
    if(!this.data.table)
      this.router.navigate(['/connections']);
    let table:Table= JSON.parse(this.data.table);
    this.columns = table.columns;
    this.tableName = table.name;
  }

  showStatistics(column: Column): void {
    this.data.column = JSON.stringify(column);
    this.router.navigate(['/statistics']);
  }

  backToConnections():void{
    this.router.navigate(['/connections']);
  }

  backToTables():void{
    this.router.navigate(['/tables']);
  }
}
