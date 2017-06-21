import {Component} from "@angular/core";
import {Connection} from "./connection";
import {Router} from "@angular/router";


@Component({
  selector: 'app',
  template: `
    <h2>My Connections</h2>
    <table border="1" class="connections">
      <tr>
        <th>url</th>
        <th>driver</th>
        <th>user</th>
        <th>password</th>
        <th>schema</th>
        <th>edit</th>
        <th>delete</th>
        <th>connect</th>
    
      </tr>
      <tr *ngFor="let connection of connections">
        <td>{{connection.url}}</td>
        <td>{{connection.driver}}</td>
        <td>{{connection.user}}</td>
        <td>{{connection.password}}</td>
        <td>{{connection.schema}}</td>
        <td><button (click)="edit()">edit</button></td>
        <td><button (click)="delete()">delete</button></td>
        <td><button (click)="connect()">connect</button></td>
      </tr>
    </table>
    <button (click)="add()">add</button>
    `
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

