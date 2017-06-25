import {Component, OnChanges, OnInit, SimpleChanges} from '@angular/core';
import {Router, ActivatedRoute} from "@angular/router";
import {AuthService} from "./auth/auth-service";

@Component({
  selector: 'my-app',
  template: `
    <style>
      .logoutLblPos{
        position:fixed;
        right:20px;
        top:5px;
      }
    </style>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <div class="page-header" style="color: #1b6d85" align="center" >
    </div>
    
    <div class="logoutLblPos">
      <button title="Выйти" class="btn btn-error glyphicon glyphicon-off" (click)="logout()"></button>
    </div>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {
  title = 'Диплом';

  constructor(private router: Router, private authService: AuthService){
    console.log(router);
  }

  logout(){
    localStorage.clear();
    this.authService.logout()
      .subscribe(
        data=>this.router.navigate(['/login']),
        error=>this.router.navigate(['/login']),
        ()=>console.log("logout finished"));
  }
}
