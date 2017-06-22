import {Component, OnInit} from "@angular/core";
import {Connection} from "./connection";
import {NgForm} from "@angular/forms";
import {ConnectionService} from "../connections/connection-service";
import {Router} from "@angular/router";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`
})

export class ConnectionComponent implements OnInit{
  constructor(private router: Router, private connectionService: ConnectionService){}

  drivers:string[];
  connection : Connection;
  // connection = new Connection(null, '', '', '', '', '');

  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.connectionService.getDrivers()
      .subscribe(
        data=>this.drivers=data,
        error=>alert("Что-то пошло не так"),
        ()=>console.log("getDrivers finished"));
  }

  add(){
    this.connectionService.add(this.connection)
      .subscribe(
        data=>alert("Успешно добавили"),
        error=>alert("Что-то пошло не так"),
        ()=>console.log("add finished"));
  }

  backToConnections():void{
    this.router.navigate(["/connections"]);
  }
}

