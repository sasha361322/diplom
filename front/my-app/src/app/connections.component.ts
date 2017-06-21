import {Component} from "@angular/core";
import {Connection} from "./connection";
import {Router} from "@angular/router";


@Component({
  selector: 'my-app',
  templateUrl: `./connections.component.html`
})

export class ConnectionsComponent{
  connections: Connection[];
  selectedConnection: Connection;

  constructor(
    // private connectionComponent: ConnectionComponent,
    private router: Router) {
    this.getConnections();
  }

  connect(): void {
    //post tables to TablesComponent???
    this.router.navigate(['/tables']);
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

  getConnections(): void {
    //get data from rest???
    // this.userService.getUsers().then(users => this.users = users);
    // this.userService.getRestUsers().subscribe((data)=>this.users=data);
    this.connections = [new Connection("qwe", "qwe", "qwe", "qwe", "qwe")];
  }
}

