import { AuthService } from './auth.service';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    register(body: {
        username: string;
        password: string;
    }): Promise<any>;
    login(body: {
        username: string;
        password: string;
    }): Promise<any>;
}
