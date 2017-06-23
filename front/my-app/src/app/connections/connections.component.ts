import {Component, OnInit} from "@angular/core";
import {Connection} from "../connection/connection";
import {Router} from "@angular/router";
import {ConnectionService} from "./connection-service";
import {Data} from "../data";


@Component({
  selector: 'my-app',
  templateUrl: `./connections.component.html`
})

export class ConnectionsComponent implements OnInit{
  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.connectionService.getAll()
      .subscribe(
        data=>this.connections=data,
        // error=>this.connections=null,
        ()=>console.log("getAll finished"));
  }

  connections: Connection[];
  selectedConnection: Connection;

  constructor(private connectionService:ConnectionService, private router: Router, private data: Data) { }


  try(connection:Connection){
    this.connectionService.try(connection)
      .subscribe(
        data=>this.connectionSuccessful(connection.id),
        error=>this.conenctionDenied(),
        ()=>console.log("try finished"));

  }
  connectionSuccessful(id:number){
    alert("Соедениение установлено");
    this.data.storage=id;
    this.router.navigate(['/tables']);
  }

  conenctionDenied(){
    alert("Невозможно подключиться к базе, исправьте параметры")
  }

  edit(connection:Connection): void {
    this.connectionService.update(connection)
      .subscribe(
        data=>this.connectionSuccessful(connection.id),
        error=>this.conenctionDenied(),
        ()=>console.log("update finished"));
    // this.router.navigate(['/tables']);
  }

  delete(id:number): void {
    this.connectionService.delete(id)
      .subscribe(
        data=>this.deleteSuccesfull(),
        error=>this.conenctionDenied(),
        ()=>console.log("delete finished"));
    // this.router.navigate(['/tables']);
  }
  deleteSuccesfull(){
    alert("Успешно удалили!");
    this.router.navigate(['/connections']);
  }
  add(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/connection']);
  }

}

