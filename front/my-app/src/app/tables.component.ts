import {Component, NgModule, Input, Output} from "@angular/core";
import {Table} from "./table";
import {Router, NavigationExtras} from "@angular/router";
import {Column} from "./column";


@Component({
  selector: 'tables-selector',
  templateUrl: `./tables.component.html`
})

export class TablesComponent{
  @Input()data:Column[];

  tables: Table[];
  constructor(private router: Router) {
    this.getTables();
  }

  showColumns(table: Table): void {
    let navigationExtras: NavigationExtras = {
      queryParams: {
        "columns": JSON.stringify(table.columns)
      }
    };
    this.router.navigate(["/tableDetails"], navigationExtras);
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


