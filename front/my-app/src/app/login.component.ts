import {Component} from "@angular/core";
import {NgForm} from "@angular/forms";
import {AuthService} from "./auth-service";
import {ActivatedRoute, Router} from "@angular/router";

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
})
export class LoginComponent {

  constructor(private loginService:AuthService, private router:Router){ }
  login(form: NgForm){
    this.loginService.login(form.value)
      .subscribe(
        data=>this.loginSuccessful(data),
        error=>this.loginDenied(),
        ()=>console.log("finished"));
    form.reset();
  }
  register(form: NgForm){
    console.log(form.value);
    this.loginService.registrate(form.value)
      .subscribe(
        data=>this.regSuccessful(),
        error=>this.regDenied(),
        ()=>console.log("finished"));
    form.reset();
  }

  loginSuccessful(token:string){
    localStorage.setItem("token",token);
    this.router.navigate(['/connections']);
  }

  loginDenied(){
    alert("Доступ запрещен");
    this.router.navigate(['/login']);
  }
  regSuccessful(){
    alert("Вы успешно зарегистрированы!")
  }
  regDenied(){
    alert("Пользователь с таким Email уже существует")
  }
}
