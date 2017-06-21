import {Component, Input, OnInit} from "@angular/core";
import {Column} from "./column";
import {Router} from "@angular/router";
import {Table} from "./table";

@Component({
  selector: 'columns',
  templateUrl: `./columns.component.html`,
})

export class ColumnsComponent implements OnInit{
  columns: Column[];
  selectedColumn: Column;
  // selectedTable: string = "123";


  constructor(
    private router: Router) {
    this.getColumns();
  }

  ngOnInit(): void {
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
