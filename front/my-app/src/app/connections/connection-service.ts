import {Injectable} from "@angular/core";
import {Http, RequestOptions, Headers, Response} from "@angular/http";
import {Observable} from "rxjs/Observable";
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/publish';
import {Connection} from "../connection/connection";

@Injectable()
export class ConnectionService{
  constructor(private http:Http) { }
  private defaultUrl='http://localhost:777/connection/';
  private tryUrl=this.defaultUrl+'try';
  private getAllUrl = this.defaultUrl+'get';
  private addUrl = this.defaultUrl+'add';
  private updateUrl = this.defaultUrl+'update';
  private deleteUrl = this.defaultUrl+'delete/';
  private getDriversUrl = this.defaultUrl+'drivers';

  try(connection:Connection):Observable<number>{
    console.log(connection);
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.post(this.tryUrl, JSON.stringify(connection), options)
      .map(this.extractStatus)
      .catch(this.handleError);
  }

  getAll():Observable<Connection[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.get(this.getAllUrl, options)
      .map(this.extractData)
      .catch(this.handleError);
  }

  add(connection:Connection):Observable<number[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.post(this.addUrl, JSON.stringify(connection), options)
      .map(this.extractStatus)
      .catch(this.handleError);
  }

  update(connection:Connection):Observable<number[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.put(this.updateUrl, JSON.stringify(connection), options)
      .map(this.extractStatus)
      .catch(this.handleError);
  }

  delete(connectionId:number):Observable<number[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.delete(this.deleteUrl+connectionId, options)
      .map(this.extractStatus)
      .catch(this.handleError);
  }

  getDrivers():Observable<string[]>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    headers.append("Authorization",localStorage.getItem("token"));
    let options = new RequestOptions({ headers: headers });
    return this.http.get(this.getDriversUrl, options)
      .map(this.extractData)
      .catch(this.handleError);
  }
  private extractData(res : Response){
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
  private extractStatus(res: Response) {
    return res.status;
  }

}
