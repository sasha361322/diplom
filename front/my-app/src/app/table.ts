import {Column} from "./column";
export class Table {
  name: string;
  columnCount: number;
  rowCount: number;
  columns: Column[];

  constructor(name: string, columnCount: number, rowCount: number, columns: Column[]){
    this.name = name;
    this.columnCount = columnCount;
    this.rowCount = rowCount;
    this.columns = columns;
  }
}
