import {Component} from "@angular/core";
import {Column} from "./column";
import {Router} from "@angular/router";

@Component({
  selector: 'app',
  templateUrl: `./columns.component.html`
})

export class ColumnsComponent{
  columns: Column[];
  selectedColumn: Column;

  constructor(
    // private connectionComponent: ConnectionComponent,
    private router: Router) {
    this.getColumns();
  }

  showStatistics(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/statistics']);
  }

  getColumns(): void {
    //get data from rest???
    // this.userService.getUsers().then(users => this.users = users);
    // this.userService.getRestUsers().subscribe((data)=>this.users=data);
    this.columns = [new Column()];
  }
}
