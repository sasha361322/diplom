export class Scheduler {
  cron: string;
  name: string;
}
export class SchedulerComponent{
  scheduler: Scheduler = {
    cron: '/5 * * * * ? *',
    name: 'every 5 seconds'
  };
}
