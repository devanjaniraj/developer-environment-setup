# 🐳 Docker Commands Cheat Sheet

Essential Docker commands for containerized development.

## 📑 Table of Contents
- [Container Management](#container-management)
- [Image Management](#image-management)
- [Docker Compose](#docker-compose)
- [Networking](#networking)
- [Volumes](#volumes)
- [System](#system)

---

## Container Management

```bash
# List containers
docker ps                    # Running containers
docker ps -a                 # All containers
docker ps -q                 # Only container IDs

# Run container
docker run <image>
docker run -d <image>        # Detached mode
docker run -it <image>       # Interactive
docker run --name <name> <image>
docker run -p 8080:80 <image>  # Port mapping
docker run -v /host:/container <image>  # Volume mount
docker run --env KEY=value <image>

# Start/Stop containers
docker start <container>
docker stop <container>
docker restart <container>

# Remove containers
docker rm <container>
docker rm -f <container>     # Force remove
docker rm $(docker ps -aq)   # Remove all

# Execute commands in container
docker exec <container> <command>
docker exec -it <container> bash
docker exec -it <container> sh

# View logs
docker logs <container>
docker logs -f <container>   # Follow logs
docker logs --tail 100 <container>

# Inspect container
docker inspect <container>
docker stats <container>     # Real-time stats

# Copy files
docker cp <container>:/path /host/path
docker cp /host/path <container>:/path
```

## Image Management

```bash
# List images
docker images
docker images -a

# Pull image
docker pull <image>
docker pull <image>:<tag>

# Build image
docker build -t <name> .
docker build -t <name>:<tag> .
docker build --no-cache -t <name> .

# Remove images
docker rmi <image>
docker rmi -f <image>        # Force remove
docker rmi $(docker images -q)  # Remove all

# Tag image
docker tag <image> <new-name>:<tag>

# Push image
docker push <image>:<tag>

# Save/Load images
docker save <image> > image.tar
docker load < image.tar

# History
docker history <image>

# Scan for vulnerabilities
docker scan <image>
```

## Docker Compose

```bash
# Start services
docker-compose up
docker-compose up -d         # Detached mode
docker-compose up --build    # Rebuild images

# Stop services
docker-compose down
docker-compose down -v       # Remove volumes
docker-compose down --rmi all  # Remove images

# View services
docker-compose ps
docker-compose ps -a

# View logs
docker-compose logs
docker-compose logs -f <service>
docker-compose logs --tail=100

# Execute commands
docker-compose exec <service> <command>
docker-compose exec <service> bash

# Restart services
docker-compose restart
docker-compose restart <service>

# Build services
docker-compose build
docker-compose build --no-cache

# Scale services
docker-compose up -d --scale <service>=3

# Validate config
docker-compose config
```

## Networking

```bash
# List networks
docker network ls

# Create network
docker network create <network>
docker network create --driver bridge <network>

# Connect/Disconnect
docker network connect <network> <container>
docker network disconnect <network> <container>

# Inspect network
docker network inspect <network>

# Remove network
docker network rm <network>

# Prune unused networks
docker network prune
```

## Volumes

```bash
# List volumes
docker volume ls

# Create volume
docker volume create <volume>

# Inspect volume
docker volume inspect <volume>

# Remove volume
docker volume rm <volume>

# Prune unused volumes
docker volume prune

# Backup volume
docker run --rm -v <volume>:/data -v $(pwd):/backup ubuntu tar czf /backup/backup.tar.gz /data

# Restore volume
docker run --rm -v <volume>:/data -v $(pwd):/backup ubuntu tar xzf /backup/backup.tar.gz -C /
```

## System

```bash
# System info
docker info
docker version

# Disk usage
docker system df

# Clean up
docker system prune          # Remove unused data
docker system prune -a       # Remove all unused images
docker system prune --volumes  # Include volumes

# Events
docker events
docker events --filter 'container=<name>'
```

## 💡 Common Workflows

### Development Environment

```bash
# Start databases
docker-compose up -d postgres mongodb redis

# View logs
docker-compose logs -f

# Stop everything
docker-compose down
```

### Building and Testing

```bash
# Build image
docker build -t myapp:test .

# Run tests
docker run --rm myapp:test npm test

# Push to registry
docker tag myapp:test registry.com/myapp:latest
docker push registry.com/myapp:latest
```

### Debugging

```bash
# Enter running container
docker exec -it <container> bash

# View container logs
docker logs -f <container>

# Inspect container
docker inspect <container> | grep IPAddress
```

### Database Backup

```bash
# PostgreSQL backup
docker exec <postgres-container> pg_dump -U postgres dbname > backup.sql

# MongoDB backup
docker exec <mongo-container> mongodump --out /backup

# Restore
docker exec -i <postgres-container> psql -U postgres dbname < backup.sql
```

## 📄 Example docker-compose.yml

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  mongodb:
    image: mongo:7
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
  mongo_data:
```

## 📄 Example Dockerfile

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
```

## 🛠️ Docker Aliases

Add to your shell config:

```bash
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dprune='docker system prune -a --volumes'
```

## 📚 Learn More

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

**Happy Containerizing! 🐳**
