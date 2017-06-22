import { NgModule }                 from '@angular/core';
import { BrowserModule }            from '@angular/platform-browser';
import { FormsModule }              from '@angular/forms';
import { HttpModule, JsonpModule }  from '@angular/http';

import { AppComponent }         from "./app.component";

import {AppRoutingModule} from "./app-routing.module";
import {LoginComponent} from "./auth/login.component";
import {ConnectionComponent} from "./connection/connection.component";
import {ConnectionsComponent} from "./connections/connections.component";
import {HistogramComponent} from "./histogram/histogram.component";
import {ColumnsComponent} from "./columns/columns.component";
import {AuthService} from "./auth/auth-service";
import {ConnectionService} from "./connections/connection-service";
import {Data} from "./data";
import {TablesComponent} from "./tables/tables.component";
import {TableService} from "./tables/table-service";

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
    LoginComponent,
    ConnectionComponent,
    ConnectionsComponent,
    TablesComponent,
    ColumnsComponent,
    HistogramComponent
  ],
  providers:    [
    AuthService,
    ConnectionService,
    Data,
    TableService
  ],
  bootstrap:    [
    AppComponent
  ]
})

export class AppModule { }
