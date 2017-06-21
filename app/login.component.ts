import {Component} from "@angular/core";
import {User} from "./user";

@Component({
  selector: 'my-app',
  template: `
    <div>
      <label>Email: </label>
      <input [(ngModel)]="user.username" placeholder="email"/>
      <label>last_name: </label>
      <label>Password: </label>
      <input [(ngModel)]="user.password" placeholder="password"/>
    </div>
    `
})

export class LoginComponent{
  user: User;
}
