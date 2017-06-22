export class Connection {
  constructor(
    public id: number,
    public url: string,
    public driver: string,
    public user: string,
    public password: string,
    public schema: string
  ){}
}
