import {Component} from "@angular/core";
import {Table} from "./table";
import {Router} from "@angular/router";
import {Column} from "./column";

@Component({
  selector: 'app',
  template: `
    <h2>My Tables</h2>
      <table border="1" class="tables">
        <tr>
          <th>name</th>
          <th>columnCount</th>
          <th>rowCount</th>
          <th>columns</th>
          <th>show statistics</th>
      
        </tr>
        <tr *ngFor="let table of tables">
          <td [class.selected]="table === selectedTable">{{table.name}}</td>
          <td [class.selected]="table === selectedTable">{{table.columnCount}}</td>
          <td [class.selected]="table === selectedTable">{{table.rowCount}}</td>
          <td [class.selected]="table === selectedTable">
            <li *ngFor="let column of table.columns">
                {{column.name}}
            </li></td>
          <td [class.selected]="table === selectedTable">{{table.schema}}</td>
          <td *ngIf="table === selectedTable"><button (click)="showColumns()">View Details</button></td>
        </tr>
      </table>`
})

export class TablesComponent{
  tables: Table[];
  selectedTable: Table;

  constructor(private router: Router) {
    this.getTables();
  }

  showColumns(): void {
    //post columns to ColumnsComponent???
    this.router.navigate(['/columns']);
  }

  getTables(): void{
    //get data from rest
    this.tables = [new Table("qwe", 5, 123, [])];
  }
}
