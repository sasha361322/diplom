import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from "./auth/login.component";
import {TablesComponent} from "./tables/tables.component";
import {ColumnsComponent} from "./columns.component";
import {HistogramComponent} from "./histogram.component";
import {ConnectionsComponent} from "./connections/connections.component";
import {ConnectionComponent} from "./connection/connection.component";

const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login',  component: LoginComponent },
  { path: 'connections',  component: ConnectionsComponent},
  { path: 'connection',  component: ConnectionComponent },
  { path: 'tables',  component: TablesComponent },
  { path: 'tableDetails',  component: ColumnsComponent, data: {isProd: true} },
  { path: 'statistics',  component: HistogramComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
