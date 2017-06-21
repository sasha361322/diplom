"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
var core_1 = require("@angular/core");
var http_1 = require("@angular/http");
require("rxjs/add/operator/map");
var mock_users_1 = require("./mock-users");
var HttpClient = (function () {
    function HttpClient(http) {
        this.http = http;
    }
    HttpClient.prototype.createAuthorizationHeader = function (headers) {
        // headers.append('Authorization', 'Basic ' +
        //   btoa('ashipilov%40cinimex.ru:password'));
        headers.append('Accept', 'application/json');
        headers.append('Content-Type', 'application/json');
        headers.append('email', 'ashipilov%40cinimex.ru');
        headers.append('password', 'password');
        headers.append('Submit', 'login');
    };
    HttpClient.prototype.get = function (url) {
        var headers = new http_1.Headers();
        this.createAuthorizationHeader(headers);
        return this.http.get(url, {
            headers: headers
        });
    };
    HttpClient.prototype.post = function (url, data) {
        var headers = new http_1.Headers();
        this.createAuthorizationHeader(headers);
        return this.http.post(url, data, {
            headers: headers
        });
    };
    return HttpClient;
}());
HttpClient = __decorate([
    core_1.Injectable(),
    __metadata("design:paramtypes", [http_1.Http])
], HttpClient);
exports.HttpClient = HttpClient;
var UserService = (function () {
    function UserService(httpClient) {
        this.userUrl = 'http://localhost:8080/rest/';
        this.loginDetails = { login: 'ashipilov%40cinimex.ru', pass: 'password' };
        this.http = httpClient;
    }
    UserService.prototype.getUsers = function () {
        return Promise.resolve(mock_users_1.USERS);
    };
    UserService.prototype.loginNow = function () {
        var _this = this;
        var headers = new http_1.Headers();
        headers.append('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'email=ashipilov%40cinimex.ru&password=password&Submit=Login';
        var options = new http_1.RequestOptions({ headers: headers });
        new Promise(function (resolve) {
            _this.http.post("http://localhost:8080/login", body).subscribe(function (data) {
                alert('login ' + data);
                console.log(data);
                if (data.json()) {
                    console.log(data);
                    resolve(data.json());
                }
                else {
                    console.log("Error");
                }
            });
        }).catch(function (error) { return console.log(error); });
    };
    UserService.prototype.getRestUsers = function () {
        // this.loginNow();
        return this.http.get(this.userUrl + 'userdto')
            .map(function (resp) {
            // alert('get '+resp);
            console.log(resp);
            //   alert(resp.json());
            //   console.log(resp.json().data);
            var usersList = resp.json().data;
            return usersList;
        });
    };
    UserService.prototype.getUser = function (id) {
        return this.getUsers()
            .then(function (users) { return users.find(function (user) { return user.id === id; }); });
    };
    return UserService;
}());
UserService = __decorate([
    core_1.Injectable(),
    __metadata("design:paramtypes", [HttpClient])
], UserService);
exports.UserService = UserService;
//# sourceMappingURL=user.service.js.map