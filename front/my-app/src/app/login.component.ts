import {Component} from "@angular/core";
import {NgForm} from "@angular/forms";

@Component({
  selector: 'app',
  styles: [`
        input.ng-touched.ng-invalid {border:solid red 2px;}
        input.ng-touched.ng-valid {border:solid green 2px;}
    `],
  template: `
    <form #myForm="ngForm" novalidate>
          <div class="form-group">
              <label>Email</label>
              <input class="form-control" name="username" ngModel required pattern="[a-zA-Z_0-9]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}" />
          </div>
          <div class="form-group">
              <label>Пароль</label>
              <input type="password" class="form-control" name="password" ngModel required pattern="[a-zA-Z_0-9.!?]{8,15}" />
          </div>
      <div class="form-group">
        <button [disabled]="myForm.invalid"
                class="btn btn-default" (click)="login(myForm)">Войти</button>
        <button [disabled]="myForm.invalid"
                class="btn btn-default" (click)="register(myForm)">Зарегистрироваться</button>
      </div>
    </form>
  `
})
export class LoginComponent{

  login(form: NgForm){
    console.log(form.value);

  }
  register(form: NgForm){
    console.log(form.value);
  }
}
