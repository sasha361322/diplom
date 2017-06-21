import { NgModule }                 from '@angular/core';
import { BrowserModule }            from '@angular/platform-browser';
import { FormsModule }              from '@angular/forms';
import { HttpModule, JsonpModule }  from '@angular/http';

import { AppComponent }         from "./app.component";

import {AppRoutingModule} from "./app-routing.module";
import {LoginComponent} from "./login.component";
import {ConnectionComponent} from "./connection.component";
import {ConnectionsComponent} from "./connections.component";
import {TablesComponent} from "./tables.component";
import {HistogramComponent} from "./histogram.component";
import {ColumnsComponent} from "./column.component";

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
    LoginService
  ],
  bootstrap:    [
    AppComponent
  ]
})

export class AppModule { }
