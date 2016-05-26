import {Component, Injectable} from '@angular/core';
import {TranslatePipe, TranslateService} from 'ng2-translate/ng2-translate';
import {Router, ROUTER_DIRECTIVES} from '@angular/router-deprecated';
import {Breadcrumb} from './breadcrumb.service';
@Component({
    selector: 'breadcrumb',
    templateUrl: 'app/breadcrumb/breadcrumb.html',
    styleUrls: [
        require('./breadcrumb.scss')
    ],
    inputs: [
        'title',
        'description',
        'parents'
    ],
    directives: [ROUTER_DIRECTIVES],
    providers: [],
    pipes: [TranslatePipe]
})

@Injectable()
export class BreadcrumbService {
    public breadcrumb: Breadcrumb;

    constructor(public translate: TranslateService,
                public router: Router) {
    }

    ngOnInit() {
        this.breadcrumb = new Breadcrumb(this.router);
    }
}
