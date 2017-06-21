import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `
    <h1>{{title}}</h1>
    <nav>
      <a routerLink="/login" routerLinkActive="active">Login</a>
      <a routerLink="/connection" routerLinkActive="active">conn</a>
      <a routerLink="/connections" routerLinkActive="active">conns</a>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {
  title = 'Диплом';
}
