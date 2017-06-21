import {Component} from "@angular/core";
import {Connection} from "./connection";
import {NgForm} from "@angular/forms";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`
})

export class ConnectionComponent{
  connection: Connection;

  add(form: NgForm){
    console.log(form.value);
  }

}
