import { NgModule }                 from '@angular/core';
import { BrowserModule }            from '@angular/platform-browser';
import { FormsModule }              from '@angular/forms';
import { HttpModule, JsonpModule }  from '@angular/http';

import { AppComponent }         from "./app.component";
import { DashboardComponent }   from "./dashboard.component";
import { UsersComponent }       from './users.component';
import { UserDetailComponent }  from "./user-detail.component"
import {HttpClient, UserService} from "./user.service";

import {AppRoutingModule} from "./app-routing.module";

@NgModule({
  imports:      [
    BrowserModule,
    FormsModule,
    HttpModule,
    JsonpModule,
    AppRoutingModule
  ],
  declarations: [
    AppComponent,
    DashboardComponent,
    UserDetailComponent,
    UsersComponent
  ],
  providers:    [
    UserService, HttpClient
  ],
  bootstrap:    [
    AppComponent
  ]
})

export class AppModule { }
