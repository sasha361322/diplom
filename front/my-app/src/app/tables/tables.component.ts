import {Component, OnInit} from "@angular/core";
import {Table} from "./table";
import {Router} from "@angular/router";
import {Data} from "../data";
import {TableService} from "./table-service";
import {saveAs as importedSaveAs} from "file-saver";

@Component({
  selector: 'tables-selector',
  templateUrl: `./tables.component.html`
})

export class TablesComponent implements OnInit{
  tables: Table[];
  token:any;

  constructor(private router: Router, private data: Data, private tableService:TableService) {
  }

  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.token=localStorage.getItem("token");
    if(!this.data.storage)
      this.router.navigate(['/connections']);

    this.tableService.getTables(this.data.storage)
      .subscribe(
        data=>this.tables=data,
        ()=>console.log("getTables finished"));

  }


  showColumns(table: Table){
    this.data.tables = JSON.stringify(this.tables);
    this.data.table = JSON.stringify(table);
    this.router.navigate(["/tableDetails"]);
  }

  getXml():void{
    this.tableService.downloadFile(this.data.storage).subscribe(blob => {
        importedSaveAs(blob, "statistics.xml");
      }
    )
  }

  backToConnections():void{
    this.router.navigate(['/connections']);
  }
}


