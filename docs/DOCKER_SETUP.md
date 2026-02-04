# 🐳 Docker & Database Setup

Complete guide to setting up and using Docker with databases in your development environment.

## Prerequisites

- Docker Desktop installed
- Basic Docker knowledge (optional)
- docker-compose available

## Docker Installation

### Download and Install

1. Visit https://www.docker.com/products/docker-desktop
2. Download Docker Desktop for Windows
3. Run the installer
4. Choose Hyper-V or WSL 2 installation
5. Complete installation
6. Restart your computer

### Verify Installation

```powershell
docker --version       # Should show Docker version
docker run hello-world # Should print hello message
```

---

## Docker Basics

### Essential Commands

```powershell
# View images
docker images

# View running containers
docker ps

# View all containers (including stopped)
docker ps -a

# Run a container
docker run -d --name my-container image-name

# Stop a container
docker stop my-container

# Start a container
docker start my-container

# Remove a container
docker rm my-container

# View logs
docker logs my-container
docker logs -f my-container  # Follow logs

# Execute command in container
docker exec -it my-container bash

# Remove an image
docker rmi image-name
```

---

## Docker Compose

### What is Docker Compose?

Docker Compose allows you to define and run multiple containers as a single application.

### docker-compose.yml Structure

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    
  mongodb:
    image: mongo:7.0
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db

volumes:
  postgres_data:
  mongodb_data:
```

### Essential Docker Compose Commands

```powershell
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Follow specific service logs
docker-compose logs -f postgres

# View services
docker-compose ps

# Execute command in service
docker-compose exec postgres psql -U postgres

# Rebuild services
docker-compose build

# Remove volumes
docker-compose down -v
```

---

## Included Databases

Your setup includes 5 production-ready databases via Docker:

### PostgreSQL

```powershell
# Connection details
Host: localhost
Port: 5432
User: postgres
Password: password
Database: postgres

# Connect with psql
docker-compose exec postgres psql -U postgres

# Example SQL
CREATE DATABASE mydb;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES ('John', 'john@example.com');
SELECT * FROM users;
```

### MongoDB

```powershell
# Connection details
Host: localhost
Port: 27017
Database: admin

# Connect with mongo shell
docker-compose exec mongodb mongosh

# Example commands
use mydb
db.users.insertOne({ name: 'John', email: 'john@example.com' })
db.users.find()
db.users.updateOne({ name: 'John' }, { $set: { status: 'active' } })
db.users.deleteOne({ name: 'John' })
```

### Redis

```powershell
# Connection details
Host: localhost
Port: 6379

# Connect with redis-cli
docker-compose exec redis redis-cli

# Example commands
SET mykey "Hello"
GET mykey
INCR counter
LPUSH mylist "item1"
LRANGE mylist 0 -1
DEL mykey
```

### MySQL

```powershell
# Connection details
Host: localhost
Port: 3306
User: root
Password: rootpassword

# Connect with mysql
docker-compose exec mysql mysql -u root -p

# Example SQL
CREATE DATABASE mydb;
USE mydb;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES ('John', 'john@example.com');
SELECT * FROM users;
```

### Elasticsearch

```powershell
# Connection details
Host: localhost
Port: 9200

# Test connection
curl http://localhost:9200/

# Create index
curl -X PUT http://localhost:9200/my-index

# Add document
curl -X POST http://localhost:9200/my-index/_doc -H "Content-Type: application/json" -d '{"name":"John","age":30}'

# Search
curl http://localhost:9200/my-index/_search
```

---

## Start All Databases

### With Docker Compose

```powershell
# Navigate to repository
cd developer-environment-setup

# Start all databases
docker-compose up -d

# Check status
docker-compose ps

# Stop all databases
docker-compose down
```

### View Logs

```powershell
# All services
docker-compose logs

# Specific service
docker-compose logs postgres
docker-compose logs mongodb
docker-compose logs redis

# Follow logs
docker-compose logs -f postgres
```

---

## Connect from Node.js

### PostgreSQL with pg

```powershell
npm install pg

# Create connection
```

```javascript
const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  password: 'password',
  host: 'localhost',
  port: 5432,
  database: 'postgres'
});

// Query
pool.query('SELECT * FROM users', (err, res) => {
  console.log(res.rows);
});
```

### MongoDB with mongoose

```powershell
npm install mongoose

# Connect
```

```javascript
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/mydb');

const userSchema = new mongoose.Schema({
  name: String,
  email: String
});

const User = mongoose.model('User', userSchema);

// Create
const user = new User({ name: 'John', email: 'john@example.com' });
user.save();

// Find
User.find({}, (err, users) => {
  console.log(users);
});
```

### Redis with redis

```powershell
npm install redis

# Connect
```

```javascript
const redis = require('redis');
const client = redis.createClient({
  host: 'localhost',
  port: 6379
});

client.connect();

// Set
client.set('mykey', 'Hello');

// Get
client.get('mykey', (err, reply) => {
  console.log(reply);
});
```

---

## Connect from Python

### PostgreSQL with psycopg2

```powershell
pip install psycopg2-binary
```

```python
import psycopg2

conn = psycopg2.connect(
    host='localhost',
    port=5432,
    user='postgres',
    password='password',
    database='postgres'
)

cur = conn.cursor()
cur.execute('SELECT * FROM users')
rows = cur.fetchall()
print(rows)

cur.close()
conn.close()
```

### MongoDB with pymongo

```powershell
pip install pymongo
```

```python
from pymongo import MongoClient

client = MongoClient('mongodb://localhost:27017/')
db = client['mydb']
users = db['users']

# Insert
users.insert_one({'name': 'John', 'email': 'john@example.com'})

# Find
for user in users.find():
    print(user)

# Update
users.update_one({'name': 'John'}, {'$set': {'status': 'active'}})
```

### Redis with redis-py

```powershell
pip install redis
```

```python
import redis

r = redis.Redis(host='localhost', port=6379, decode_responses=True)

# Set
r.set('mykey', 'Hello')

# Get
value = r.get('mykey')
print(value)

# Increment
r.incr('counter')

# List operations
r.lpush('mylist', 'item1', 'item2')
items = r.lrange('mylist', 0, -1)
print(items)
```

---

## Common Docker Issues

### Issue: Docker won't start

**Solution**:
1. Make sure Docker Desktop is installed and running
2. Check if Hyper-V is enabled (Windows 10 Pro/Enterprise)
3. Or enable WSL 2
4. Restart Docker Desktop
5. Restart your computer if needed

### Issue: Port already in use

**Solution**:
```powershell
# Find process using port
netstat -ano | findstr :5432

# Kill process
taskkill /PID <PID> /F

# Or change port in docker-compose.yml
```

### Issue: Out of disk space

**Solution**:
```powershell
# Clean up Docker resources
docker system prune

# Remove unused volumes
docker volume prune

# Remove all unused containers, networks, and images
docker system prune -a
```

### Issue: Container won't start

**Solution**:
```powershell
# Check logs
docker-compose logs postgres

# Recreate container
docker-compose down
docker-compose up -d

# Force rebuild
docker-compose up -d --build
```

---

## Best Practices

1. **Use volumes for persistence** - Data survives container restarts
2. **Use environment variables** - Don't hardcode credentials
3. **Resource limits** - Set memory and CPU limits
4. **Health checks** - Monitor container health
5. **Named containers** - Use meaningful names
6. **Keep containers small** - Minimal images are faster
7. **Use specific image tags** - Avoid 'latest' tag
8. **Secure credentials** - Use .env files, not docker-compose.yml
9. **Regular backups** - Back up database volumes
10. **Monitor logs** - Check logs regularly for errors

---

## Resources

- [Docker Official Docs](https://docs.docker.com/)
- [Docker Compose Docs](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/) - Container images
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [MongoDB Docs](https://docs.mongodb.com/)
- [Redis Docs](https://redis.io/documentation)

