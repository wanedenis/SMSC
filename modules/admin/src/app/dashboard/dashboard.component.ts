import {Component, OnInit} from "@angular/core";
import {ActivatedRoute, Params, Router} from "@angular/router";
import {MenuItem} from "primeng/components/common/api";
import {DashboardBox} from "./dashboard-box/dashboard-box.model";
import {DragulaService} from "ng2-dragula";
import {DashboardBoxService} from "./dashboard-box/dashboard-box.service";
import {NotificationService} from "../services/notification-service";
import * as _ from "lodash";

@Component({
    selector: 'dashboard',
    templateUrl: './dashboard.component.html',
    styleUrls: ['./dashboard.component.scss'],
    providers: [DragulaService]
})
export class DashboardComponent implements OnInit {

    id: number = null;

    dashboardBoxes: DashboardBox[] = [];

    menuItems: MenuItem[];

    constructor(public route: ActivatedRoute,
                public router: Router,
                public dashboardBoxService: DashboardBoxService,
                public dragulaService: DragulaService,
                public notification: NotificationService) {
    }

    public onDropModel() {
        this.dashboardBoxes.forEach((dashboardBox, i, dashboardBoxes) => {
            if (dashboardBox.order !== i + 1) {
                dashboardBoxes[i].order = i + 1;
                this.dashboardBoxService.updateResource(dashboardBoxes[i])
                    .subscribe(null, (e) => {
                        this.notification.createNotification('error', 'ERROR', 'ERROR_UPDATE');
                    });
            }
        });
    }

    ngOnInit() {
        this.dragulaService.setOptions('dashboard-boxes', {direction: 'horizontal'});
        this.dragulaService.dropModel.subscribe((value) => this.onDropModel());

        this.route.paramMap.subscribe((params: Params) => {
            this.id = Number(params.get('id'));
            this.dashboardBoxes = this.getDashboardBoxes();
            this.dashboardBoxes = this.sortDashboardBoxes(this.dashboardBoxes);
        });
    }

    sortDashboardBoxes(dashboardBoxes: DashboardBox[]) {
        return _.sortBy(dashboardBoxes, [(dashboardBox: DashboardBox) => dashboardBox.order]);
    }

    isDashboardBoxes(): boolean {
        return this.dashboardBoxes.length > 0;
    }

    getDashboardBoxes(): DashboardBox[] {
        return <DashboardBox[]>this.route.snapshot.data['dashboard'];
    }
}
