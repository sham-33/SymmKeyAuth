import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
export declare class AuthService {
    private usersService;
    private jwtService;
    constructor(usersService: UsersService, jwtService: JwtService);
    register(username: string, password: string): Promise<any>;
    login(username: string, password: string): Promise<any>;
    validateUser(userId: number): Promise<any>;
}
