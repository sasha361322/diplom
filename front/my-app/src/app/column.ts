import {Histogram} from "./histogram";
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
