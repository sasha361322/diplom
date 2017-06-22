import {Component} from "@angular/core";
import {Connection} from "./connection";
import {NgForm} from "@angular/forms";
import {ConnectionService} from "../connections/connection-service";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`
})

export class ConnectionComponent{
  constructor(private connectionService: ConnectionService){}

  connection = new Connection(null, '', '', '', '', '');

  add(){
    this.connectionService.add(this.connection)
      .subscribe(
        data=>alert("Успешно добавили"),
        error=>alert("Что-то пошло не так"),
        ()=>console.log("add finished"));
  }

}

