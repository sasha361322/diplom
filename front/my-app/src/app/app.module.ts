import { NgModule }                 from '@angular/core';
import { BrowserModule }            from '@angular/platform-browser';
import {FormsModule, ReactiveFormsModule}              from '@angular/forms';
import { HttpModule, JsonpModule }  from '@angular/http';

import { AppComponent }         from "./app.component";

import {AppRoutingModule} from "./app-routing.module";
import {LoginComponent} from "./auth/login.component";
import {ConnectionsComponent} from "./connections/connections.component";
import {HistogramComponent} from "./histogram/histogram.component";
import {ColumnsComponent} from "./columns/columns.component";
import {AuthService} from "./auth/auth-service";
import {ConnectionService} from "./connections/connection-service";
import {Data} from "./data";
import {TablesComponent} from "./tables/tables.component";
import {TableService} from "./tables/table-service";
import { BarchartComponent } from './histogram/barchart.component';
import {ConnectionComponent} from "./connection/connection_component";

@NgModule({
  imports:      [
    BrowserModule,
    FormsModule,
    HttpModule,
    JsonpModule,
    AppRoutingModule,
    ReactiveFormsModule
  ],
  declarations: [
    AppComponent,
    LoginComponent,
    ConnectionComponent,
    ConnectionsComponent,
    TablesComponent,
    ColumnsComponent,
    HistogramComponent,
    BarchartComponent
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
