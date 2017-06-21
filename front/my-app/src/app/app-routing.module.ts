import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from "./login.component";
import {ConnectionComponent } from "./connection.component";
import {ConnectionsComponent} from "./connections.component";
import {TablesComponent} from "./tables.component";
import {ColumnsComponent} from "./columns.component";
import {HistogramComponent} from "./histogram.component";

const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login',  component: LoginComponent },
  { path: 'connection',  component: ConnectionComponent },
  { path: 'connections',  component: ConnectionsComponent },
  { path: 'tables',  component: TablesComponent },
  { path: 'tableDetails',  component: ColumnsComponent },
  { path: 'statistics',  component: HistogramComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
