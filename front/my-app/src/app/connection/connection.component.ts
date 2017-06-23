import {Component, OnInit} from "@angular/core";
import {Connection} from "./connection";
import {FormControl, FormGroup, NgForm, Validators} from "@angular/forms";
import {ConnectionService} from "../connections/connection-service";
import {Router} from "@angular/router";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`,
})

export class ConnectionComponent implements OnInit{
  constructor(private router: Router, private connectionService: ConnectionService){}

  drivers:string[];
  connection : FormGroup;

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

    this.connection = new FormGroup({
      url: new FormControl('', [Validators.required, Validators.minLength(2)]),
      driver: new FormControl('', Validators.required),
      user: new FormControl('', Validators.required),
      password: new FormControl(''),
      schema: new FormControl('', Validators.required)
    });
  }

  onSubmit({ value }: { value: Connection}) {
      this.connectionService.try(value)
        .subscribe(
          data=>this.add(value),
          error=>this.conenctionDenied(),
          ()=>console.log("try finished"));
  }
  add(connection: Connection){
    this.connectionService.add(connection)
      .subscribe(
        data=>this.addSuccessful,
        error=>alert("Что-то пошло не так"),
        ()=>console.log("add finished"));
  }

  addSuccessful(){
    alert("Успешно добавили");
    this.backToConnections();
  }
  backToConnections(){
    this.router.navigate(["/connections"]);
  }

  conenctionDenied(){
    alert("Невозможно подключиться к базе, исправьте параметры")
  }
}

