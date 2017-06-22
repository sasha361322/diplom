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
  // selectedColumn: Column;


  constructor(
    private route: ActivatedRoute,
    private router: Router) {
    console.log(this.columns);
    this.route.queryParams.subscribe(params => {
      console.log(params);
      this.columns = JSON.parse(params["columns"]);
    });
    console.log(this.columns);
  }

  ngOnInit(): void {
  }

  showStatistics(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/statistics']);
  }
}
