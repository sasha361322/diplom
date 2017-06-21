import {Component} from "@angular/core";
import {NgForm} from "@angular/forms";
import {LoginService} from "./login-service";

@Component({
  selector: 'my-app',
  styles: [`
        input.ng-touched.ng-invalid {border:solid red 2px;}
        input.ng-touched.ng-valid {border:solid green 2px;}
    `],
  templateUrl: `./login.component.html`
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
