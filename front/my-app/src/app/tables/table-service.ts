import {Injectable} from "@angular/core";
import {Http, RequestOptions, Headers, Response, ResponseContentType} from "@angular/http";
import {Observable} from "rxjs/Observable";
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/publish';
import {Connection} from "../connection/connection";
import {Table} from "./table";

@Injectable()
export class TableService{
  constructor(private http:Http) { }
  private defaultUrl = 'http://localhost:777/connection/';

  getTables(connectionId:number):Observable<Table[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.get(this.defaultUrl+connectionId+"/tables", options)
      .map(this.extractTablesList)
      .catch(this.handleError);
  }

  downloadFile(id:number): Observable<Blob> {
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers , responseType: ResponseContentType.Blob});
    return this.http.get(this.defaultUrl+id+"/download", options)
      .map(res => res.blob())
      .catch(this.handleError)
  }
  private extractTablesList(res : Response){
    let body = res.json();
    return body || { };
  }

  private handleError (error: Response | any) {
    // In a real world app, you might use a remote logging infrastructure
    let errMsg: string;
    if (error instanceof Response) {
      const body = error.json() || '';
      const err = body.error || JSON.stringify(body);
      errMsg = `${error.status} - ${error.statusText || ''} ${err}`;
    } else {
      errMsg = error.message ? error.message : error.toString();
    }
    console.error(errMsg);
    return Observable.throw(errMsg);
  }
}
