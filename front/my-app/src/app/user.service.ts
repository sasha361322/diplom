import { Injectable } from '@angular/core';
import {Http, Response, Headers, Jsonp, URLSearchParams, RequestOptions} from '@angular/http';
import 'rxjs/add/operator/map';

import {User} from "./user";
import {USERS} from "./mock-users";
import {Observable} from "rxjs/Observable";//https://metanit.com/web/angular2/6.2.php


@Injectable()
export class HttpClient {

  constructor(private http: Http) {}

  createAuthorizationHeader(headers: Headers) {
    // headers.append('Authorization', 'Basic ' +
    //   btoa('ashipilov%40cinimex.ru:password'));
    headers.append('Accept', 'application/json');
    headers.append('Content-Type', 'application/json');
    headers.append('email','ashipilov%40cinimex.ru');
    headers.append('password','password');
    headers.append('Submit','login');
  }

  get(url:string) {
    let headers = new Headers();
    this.createAuthorizationHeader(headers);
    return this.http.get(url, {
      headers: headers
    });
  }

  post(url:string, data:any) {
    let headers = new Headers();
    this.createAuthorizationHeader(headers);
    return this.http.post(url, data, {
      headers: headers
    });
  }
}

@Injectable()
export class UserService {
  constructor(httpClient: HttpClient) {
    this.http = httpClient;
  }
  private http:HttpClient;
  private userUrl = 'http://localhost:8080/rest/';
  private loginDetails={login:'ashipilov%40cinimex.ru',pass:'password'};
  getUsers(): Promise<User[]>{
    return Promise.resolve(USERS);
  }
  loginNow() {
    let headers = new Headers();
    headers.append('Content-Type', 'application/x-www-form-urlencoded');
    var body = 'email=ashipilov%40cinimex.ru&password=password&Submit=Login';
    let options = new RequestOptions({ headers: headers });
    new Promise((resolve) => {
      this.http.post("http://localhost:8080/login", body).subscribe((data) => {
          alert('login '+data);
          console.log(data);
          if(data.json()) {
            console.log(data);
            resolve(data.json());
          }else{
            console.log("Error");
          }
        }
      )
    }).catch((error:any)=>console.log(error));
  }

  getRestUsers() : Observable<User[]> {
    // this.loginNow();
    return this.http.get(this.userUrl + 'userdto')
      .map((resp: Response) => {
      // alert('get '+resp);
        console.log(resp);
      //   alert(resp.json());
      //   console.log(resp.json().data);
        let usersList = resp.json().data;
        return usersList;
      })
  }

  getUser(id: number): Promise<User> {
    return this.getUsers()
      .then(users => users.find(user => user.id === id));
  }
}
