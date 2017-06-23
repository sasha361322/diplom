import {Component, OnInit} from '@angular/core';
import {Router} from "@angular/router";

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
    
    <div *ngIf="token" class="logoutLblPos">
      <button class="btn btn-error glyphicon glyphicon-off" (click)="logout()"></button>
    </div>
    <router-outlet></router-outlet>
  `
})
export class AppComponent implements OnInit{
  title = 'Диплом';
  token:string;

  constructor(private router: Router){

  }

  ngOnInit(){
    this.token=localStorage.getItem("token");
  }

  logout(){
    localStorage.clear();
    this.router.navigate(['/login']);
  }
}
