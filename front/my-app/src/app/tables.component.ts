import {Component} from "@angular/core";
import {Table} from "./table";
import {Router} from "@angular/router";
import {Column} from "./column";

@Component({
  selector: 'my-app',
  templateUrl: `./tables.component.html`
})

export class TablesComponent{
  tables: Table[];
  selectedTable: Table;

  constructor(private router: Router) {
    this.getTables();
  }

  showColumns(): void {
    //post columns to ColumnsComponent???
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
