import { User } from './user.interface';
export declare class UsersService {
    private readonly users;
    private currentId;
    create(username: string, password: string): Promise<User>;
    findOne(username: string): Promise<User | undefined>;
    findById(id: number): Promise<User | undefined>;
}
