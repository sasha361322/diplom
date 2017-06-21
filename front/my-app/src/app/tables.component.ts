import {Component, NgModule, Input, Output} from "@angular/core";
import {Table} from "./table";
import {Router} from "@angular/router";


@Component({
  selector: 'tables',
  templateUrl: `./tables.component.html`
})

export class TablesComponent{
  tables: Table[];
  // selectedTable: string;

  constructor(private router: Router) {
    this.getTables();
  }

  showColumns(table: Table): void {
    //post columns to ColumnsComponent???
    // this.selectedTable = table;
    this.router.navigate(['/tableDetails']);
  }

  getTables(): void{
    //get data from rest
    this.tables = [new Table("qwe", 5, 123, [])];
  }

  getXml():void{
    //  /download GET
    this.router.navigate(['/connections']);
  }
}


