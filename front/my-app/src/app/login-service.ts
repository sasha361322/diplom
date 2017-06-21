import {Injectable} from "@angular/core";
import {Http, RequestOptions, Headers, Response} from "@angular/http";
import {Observable} from "rxjs/Observable";
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/catch';

@Injectable()
export class LoginService{
  constructor(private http:Http) { }
  private loginUrl = 'http://localhost:777/auth/signin';

  login(json:Object):Observable<string>{
    let headers = new Headers({ 'Content-Type': 'application/json' });
    let options = new RequestOptions({ headers: headers });
    return this.http.post(this.loginUrl, JSON.stringify(json), options)
      .map(this.extractData)
      .catch(this.handleError);
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
  private extractData(res: Response) {
    let body = res.json();
    return body.token || { };
  }
}
