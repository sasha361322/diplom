
import { Injectable } from '@angular/core';
import {Table} from "./tables/table";

@Injectable()
export class Data {

  public storage: any;

  public tables: any;
  public table: any;
  public column: any;

  public constructor() { }

}
