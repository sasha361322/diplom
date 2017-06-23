import {Component, OnInit} from "@angular/core";
import {Connection} from "./connection";
import {FormControl, FormGroup, NgForm, Validators} from "@angular/forms";
import {ConnectionService} from "../connections/connection-service";
import {Router} from "@angular/router";
import {Data} from "../data";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`,
})

export class ConnectionComponent implements OnInit{
  constructor(private router: Router, private connectionService: ConnectionService, private data:Data){}

  drivers:string[];
  connection : FormGroup;
  isEdit:boolean;
  button:string;
  token:any;
  ngOnInit(): void {
    if (!localStorage.getItem("token")){
      alert("Доступ запрещен");
      this.router.navigate(['/login']);
    }
    this.token=localStorage.getItem("token");
    this.connectionService.getDrivers()
      .subscribe(
        data=>this.drivers=data,
        error=>alert("Что-то пошло не так"),
        ()=>console.log("getDrivers finished"));
    if(!this.data.connection){
      this.isEdit=false;
      this.button="Добавить";
      this.connection = new FormGroup({
        url: new FormControl('', [Validators.required, Validators.minLength(2)]),
        driver: new FormControl('', Validators.required),
        user: new FormControl('', Validators.required),
        password: new FormControl(''),
        schema: new FormControl('', Validators.required),
        id: new FormControl(null)
      });
    }
    else{
      this.isEdit=true;
      this.button="Сохранить";
      let con:Connection = JSON.parse(this.data.connection);
      this.connection = new FormGroup({
        url: new FormControl(con.url, [Validators.required, Validators.minLength(2)]),
        driver: new FormControl(con.driver, Validators.required),
        user: new FormControl(con.user, Validators.required),
        password: new FormControl(con.password),
        schema: new FormControl(con.schema, Validators.required),
        id: new FormControl(con.id, Validators.required)
      });
      this.data.connection=null;
    }
  }

  onSubmit({ value }: { value: Connection}) {
      this.connectionService.try(value)
        .subscribe(
          data=>this.add(value),
          error=>this.conenctionDenied(),
          ()=>console.log("try finished"));
  }
  add(connection: Connection){
    if (!this.isEdit)
      this.connectionService.add(connection)
        .subscribe(
          data=>this.addSuccessful,
          error=>alert("Что-то пошло не так"),
          ()=>console.log("add finished"));
    else
      this.connectionService.update(connection)
        .subscribe(
          data=>this.updateSuccessful,
          error=>alert("Что-то пошло не так"),
          ()=>console.log("update finished"));
  }

  addSuccessful(){
    alert("Успешно добавили");
    this.router.navigate(["/connections"]);
  }

  updateSuccessful(){
    // alert("Успешно сохранили");
    this.backToConnections();
  }
  backToConnections(){
    this.router.navigate(["/connections"]);
  }

  conenctionDenied(){
    alert("Невозможно подключиться к базе, исправьте параметры")
  }
}

