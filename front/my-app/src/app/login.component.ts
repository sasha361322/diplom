import {Component} from "@angular/core";
import {NgForm} from "@angular/forms";
import {AuthService} from "./auth-service";
import {ActivatedRoute, Router} from "@angular/router";

@Component({
  selector: 'my-app',
  styles: [`
        input.ng-touched.ng-invalid {border:solid red 2px;}
        input.ng-touched.ng-valid {border:solid green 2px;}
    `],
  templateUrl: `./login.component.html`
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
