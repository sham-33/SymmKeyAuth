#!/bin/bash

echo "🚀 Setting up Authentication Project with PostgreSQL"
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "📝 Please create a .env file with your database credentials:"
    echo ""
    echo "DB_HOST=localhost"
    echo "DB_PORT=5432"
    echo "DB_USERNAME=your_postgres_username"
    echo "DB_PASSWORD=your_postgres_password"
    echo "DB_DATABASE=your_database_name"
    echo ""
    exit 1
fi

echo "✅ .env file found"
echo ""

# Source the .env file
export $(cat .env | xargs)

# Check PostgreSQL connection
echo "🔍 Testing PostgreSQL connection..."
if command -v psql &> /dev/null; then
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -d postgres -c "SELECT 1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ PostgreSQL connection successful"
    else
        echo "⚠️  Could not connect to PostgreSQL. Please check your credentials."
    fi
else
    echo "⚠️  psql command not found. Skipping connection test."
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Start the development server: npm run start:dev"
echo "2. Test registration: curl -X POST http://localhost:3000/auth/register -H 'Content-Type: application/json' -d '{\"username\":\"testuser\",\"password\":\"password123\"}'"
echo "3. Check DATABASE_SETUP.md for more information"
echo ""
