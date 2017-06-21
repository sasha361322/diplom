import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <div class="page-header" style="color: #1b6d85" align="center" >
        <h1><strong><b>{{title}}</b></strong> </h1>
    </div>
    <nav>
      <!--<a routerLink="/login" routerLinkActive="active">Login</a>-->
      <a routerLink="/connections" routerLinkActive="active">conns</a>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {
  title = 'Диплом';
}
