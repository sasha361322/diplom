export class Connection {
  id: number;
  url: string;
  driver: string;
  user: string;
  password: string;
  schema: string;

  constructor(url: string, driver: string, user: string, password: string, schema: string){
    this.url = url;
    this.driver = driver;
    this.user = user;
    this.password = password;
    this.schema = schema;
  }
}
