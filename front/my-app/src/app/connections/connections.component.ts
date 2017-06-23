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
  token:string;
  connections: Connection[];

  constructor(private connectionService:ConnectionService, private router: Router, private data: Data) { }

  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.token=localStorage.getItem("token");
    this.connectionService.getAll()
      .subscribe(
        data=>this.connections=data,
        // error=>this.connections=null,
        ()=>console.log("getAll finished"));
  }

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
    this.data.connection=JSON.stringify(connection);
    this.router.navigate(['/connection']);
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
    location.reload();
  }
  add(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/connection']);
  }

  logout(){
    localStorage.clear();
    this.router.navigate(['/login']);
  }

}

