import {Component, Input, OnInit} from "@angular/core";
import {Column} from "./column";
import {Router, ActivatedRoute} from "@angular/router";
import {Table} from "./table";

@Component({
  selector: 'columns-selector',
  templateUrl: `./columns.component.html`,
})

export class ColumnsComponent implements OnInit{
  columns: Column[];
  selectedColumn: Column;
  selectedTable: Table;


  constructor(
    private route: ActivatedRoute,
    private router: Router) {
    this.route.queryParams.subscribe(params => {
      this.columns = params["columns"];
    });
    // this.getColumns();
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
