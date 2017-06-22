import {Histogram} from "../histogram/histogram";
import {Injectable} from "@angular/core";

export class Column {
  name: string;
  isNullable: boolean;
  type: string;
  isPrimary: boolean;
  foreignKeyTable: string;
  foreignKeyColumn: string;
  countDistinctValues: number;
  count: number;
  listOfRareValues: any[];
  columnClassName: string;
  histogram: Histogram;
  pattern: string;
  patternCount: number;
}
