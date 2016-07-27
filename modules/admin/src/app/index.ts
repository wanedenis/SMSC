import { LocalStorageService } from "angular2-localStorage/LocalStorageEmitter";
import { AppState } from "./app.service";
import { HTTP_PROVIDERS, Http } from "@angular/http";
import { TRANSLATE_PROVIDERS, TranslateService } from "ng2-translate/ng2-translate";
import { provide } from "@angular/core";
import { ODatabaseService } from "./orientdb/orientdb.service";
import { MdIconRegistry } from "@angular2-material/icon/icon-registry";
import { DashboardGuard } from "./dashboard/dashboard.guard";
import { AuthGuard } from "./common/authGuard";
import { AuthHttp, AuthConfig } from "angular2-jwt";
import { AuthService } from "./services/auth/auth.service";
import { TokenService, AUTH_TOKEN_NAME } from "./services/auth/token.service";

export * from './app.component';
export * from './app.service';

export const APP_PROVIDERS = [
    TokenService,
    AuthService,
    AuthGuard,
    DashboardGuard,
    AppState,
    HTTP_PROVIDERS,
    LocalStorageService,
    MdIconRegistry,
    TRANSLATE_PROVIDERS,
    TranslateService,
    provide(AuthHttp, {
        useFactory: (http, tokenService) => {
            return new AuthHttp(new AuthConfig({
                headerName: 'Authorization',
                headerPrefix: 'Bearer',
                tokenName: AUTH_TOKEN_NAME,
                tokenGetter: tokenService.getToken(),
                globalHeaders: [{ 'Content-Type': 'application/json' }],
                noJwtError: true,
                noTokenScheme: true
            }), http);
        },
        deps: [Http, TokenService]
    }),
    provide(ODatabaseService, {
        useFactory: (authHttp) => new ODatabaseService('/orientdb/smsc', authHttp),
        deps: [AuthHttp]
    })
];
