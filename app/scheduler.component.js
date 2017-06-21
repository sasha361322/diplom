"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Scheduler = (function () {
    function Scheduler() {
    }
    return Scheduler;
}());
exports.Scheduler = Scheduler;
var SchedulerComponent = (function () {
    function SchedulerComponent() {
        this.scheduler = {
            cron: '/5 * * * * ? *',
            name: 'every 5 seconds'
        };
    }
    return SchedulerComponent;
}());
exports.SchedulerComponent = SchedulerComponent;
//# sourceMappingURL=scheduler.component.js.map