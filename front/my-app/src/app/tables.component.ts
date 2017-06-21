import {Component, NgModule, Input, Output} from "@angular/core";
import {Table} from "./table";
import {Router, NavigationExtras} from "@angular/router";


@Component({
  selector: 'tables-selector',
  templateUrl: `./tables.component.html`
})

export class TablesComponent{
  tables: Table[];
  selectedTable: Table;

  constructor(private router: Router) {
    this.getTables();
  }

  showColumns(table: Table): void {
    //post columns to ColumnsComponent???
    let navigationExtras: NavigationExtras = {
      queryParams: {
        "columns": table.columns
      }
    };
    this.router.navigate(["columns-selector"], this.selectedTable);
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


