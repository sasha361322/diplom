import {Component} from "@angular/core";
import {Connection} from "./connection";
import {NgForm} from "@angular/forms";


@Component({
  selector: 'my-app',
  templateUrl: `./connection.component.html`
})

export class ConnectionComponent{
  connection = new Connection("qwe", "qwe", "qwe", "qwe", "qwe");

  add(form: NgForm){
    console.log(form.value);
  }

}

