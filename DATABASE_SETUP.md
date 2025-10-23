# JWT Authentication with PostgreSQL

A NestJS application with JWT authentication using PostgreSQL database and RSA key pairs.

## Features

- ✅ User registration with password hashing (bcrypt)
- ✅ User login with JWT token generation
- ✅ Protected routes with JWT authentication
- ✅ PostgreSQL database integration with TypeORM
- ✅ RSA key pair (RS256) for JWT signing
- ✅ Environment variable configuration

## Prerequisites

- Node.js (v14 or higher)
- PostgreSQL database running
- npm or yarn

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Database

Update the `.env` file with your PostgreSQL credentials:

```env
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=your_postgres_username
DB_PASSWORD=your_postgres_password
DB_DATABASE=your_database_name
```

### 3. Generate RSA Keys (Optional - for asymmetric JWT)

If you want to use RSA keys instead of a simple secret:

```bash
npm run generate-keys
```

This will create `keys/private.key` and `keys/public.key`.

### 4. Start the Application

```bash
# Development mode
npm run start:dev

# Production mode
npm run build
npm run start:prod
```

The server will start on `http://localhost:3000`

## API Endpoints

### Public Endpoints

#### Register a New User
```bash
POST /auth/register
Content-Type: application/json

{
  "username": "testuser",
  "password": "password123"
}

Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "testuser"
  }
}
```

#### Login
```bash
POST /auth/login
Content-Type: application/json

{
  "username": "testuser",
  "password": "password123"
}

Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "testuser"
  }
}
```

### Protected Endpoints

#### Get User Profile
```bash
GET /profile
Authorization: Bearer <your_jwt_token>

Response:
{
  "message": "This is a protected route",
  "user": {
    "userId": 1,
    "username": "testuser"
  }
}
```

## Testing with cURL

### Register a user:
```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"password123"}'
```

### Login:
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"password123"}'
```

### Access protected route:
```bash
# Replace <TOKEN> with the access_token from login/register response
curl http://localhost:3000/profile \
  -H "Authorization: Bearer <TOKEN>"
```

## Database Schema

The application automatically creates the following table:

### users
| Column | Type | Constraints |
|--------|------|-------------|
| id | integer | PRIMARY KEY, AUTO INCREMENT |
| username | varchar | UNIQUE, NOT NULL |
| password | varchar | NOT NULL (hashed) |
| createdAt | timestamp | NOT NULL |
| updatedAt | timestamp | NOT NULL |

## Security Notes

⚠️ **Important for Production:**

1. Change the `JWT_SECRET` in `.env` to a strong, random value
2. Set `synchronize: false` in TypeORM configuration (app.module.ts)
3. Use migrations for database schema changes
4. Never commit `.env` file or `keys/` directory to version control
5. Use HTTPS in production
6. Implement rate limiting for login/register endpoints
7. Add password strength validation
8. Consider implementing refresh tokens

## Project Structure

```
src/
├── auth/
│   ├── auth.controller.ts    # Login & Register endpoints
│   ├── auth.service.ts        # Authentication logic
│   ├── auth.module.ts         # Auth module configuration
│   ├── jwt.strategy.ts        # JWT validation strategy
│   └── jwt-auth.guard.ts      # Guard for protected routes
├── users/
│   ├── user.entity.ts         # User database entity
│   ├── users.service.ts       # User management service
│   └── users.module.ts        # Users module
└── app.module.ts              # Main application module
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| DB_HOST | PostgreSQL host | localhost |
| DB_PORT | PostgreSQL port | 5432 |
| DB_USERNAME | Database username | - |
| DB_PASSWORD | Database password | - |
| DB_DATABASE | Database name | - |
| JWT_SECRET | Secret for JWT signing | - |
| JWT_EXPIRATION | Token expiration time | 24h |

## License

MIT
