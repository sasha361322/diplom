import {Component} from "@angular/core";
import {NgForm} from "@angular/forms";
import {LoginService} from "./login-service";

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
      
<div *ngIf="token">
{{token}}
</div>
  `
  // ,providers:[LoginService]
})
export class LoginComponent{
  constructor(private loginService:LoginService){ }
  login(form: NgForm){
    this.loginService.login(form.value)
      .subscribe(
        data=>localStorage.setItem("token",data),
        error=>alert("не авторизованы"),
        ()=>console.log("finished"));

  }
  register(form: NgForm){
    console.log(form.value);
  }
}
