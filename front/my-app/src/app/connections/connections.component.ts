import {Component, OnInit} from "@angular/core";
import {Connection} from "../connection/connection";
import {Router} from "@angular/router";
import {ConnectionService} from "./connection-service";


@Component({
  selector: 'my-app',
  templateUrl: `./connections.component.html`
})

export class ConnectionsComponent implements OnInit{
  ngOnInit(): void {
    this.getConnections();
  }

  connections: Connection[];
  selectedConnection: Connection;

  constructor(private connectionService:ConnectionService, private router: Router) { }
  // private connectionComponent: ConnectionComponent,


  try(connection:Connection){
    this.connectionService.try(connection)
      .subscribe(
        data=>this.connectionSuccessful(),
        error=>this.conenctionDenied(),
        ()=>console.log("finished"));
  }
  connectionSuccessful(){
    alert("Соедениение установлено");
    this.router.navigate(['/tables']);
  }
  conenctionDenied(){
    alert("Невозможно подключиться к базе, исправьте параметры")
  }

  edit(): void {
    // this.router.navigate(['/tables']);
  }

  delete(): void {
    // this.router.navigate(['/tables']);
  }

  add(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/connection']);
  }

  getConnections(){
    //get data from rest???
    // this.userService.getUsers().then(users => this.users = users);
    // this.userService.getRestUsers().subscribe((data)=>this.users=data);
    this.connections = [new Connection("qwe", "h2", "qwe", "qwe", "qwe")];
  }
}

