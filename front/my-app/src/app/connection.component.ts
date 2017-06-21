import {Component} from "@angular/core";
import {Connection} from "./connection";
import {NgForm} from "@angular/forms";


@Component({
  selector: 'app',
  template: `
    <form #myForm="ngForm" action="post"> 
      <div>
        <label>url: </label>
        <input class="form-control" name="url" ngModel required/><br>
        <label>driver: </label>
        <input class="form-control" name="driver" ngModel required/><br>
        <label>user: </label>
        <input class="form-control" name="user" ngModel required/><br>
        <label>password: </label>
        <input class="form-control" name="password" ngModel required/><br>
        <label>schema: </label>
        <input class="form-control" name="schema" ngModel required/><br>
      </div>
      <div class="form-group">
        <button [disabled]="myForm.invalid"
                class="btn btn-default" (click)="add(myForm)">Сохранить</button>
      </div>
     </form>
    `
})

export class ConnectionComponent{
  connection: Connection;

  add(form: NgForm){
    console.log(form.value);
  }

}

