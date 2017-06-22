import {Column} from "../columns/column";
import {Injectable} from "@angular/core";

export class Table {
  name: string;
  columnCount: number;
  rowCount: number;
  columns: Column[];
}
