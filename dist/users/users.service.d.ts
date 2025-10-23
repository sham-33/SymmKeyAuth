import { Repository } from 'typeorm';
import { User } from './user.entity';
export declare class UsersService {
    private usersRepository;
    constructor(usersRepository: Repository<User>);
    create(username: string, password: string): Promise<User>;
    findOne(username: string): Promise<User | undefined>;
    findById(id: number): Promise<User | undefined>;
}
