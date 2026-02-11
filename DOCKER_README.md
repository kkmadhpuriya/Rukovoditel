# Docker Setup for Rukovoditel

## Quick Start

### 1. Build and Run with Docker Compose

```bash
# Start the application and database
docker-compose up -d

# View logs
docker-compose logs -f
```

The application will be available at: **http://localhost:8080**

### 2. Build Docker Image Only

```bash
# Build the image
docker build -t rukovoditel:latest .

# Run the container (you'll need to set up MySQL separately)
docker run -d -p 8080:80 \
  -e DB_SERVER=your_mysql_host \
  -e DB_SERVER_USERNAME=your_username \
  -e DB_SERVER_PASSWORD=your_password \
  -e DB_DATABASE=rukovoditel \
  --name rukovoditel-app \
  rukovoditel:latest
```

## Configuration

### Environment Variables

The Docker container uses the following environment variables (set in `docker-compose.yml`):

| Variable             | Default Value          | Description       |
| -------------------- | ---------------------- | ----------------- |
| `DB_SERVER`          | `mysql`                | Database host     |
| `DB_SERVER_USERNAME` | `rukovoditel_user`     | Database username |
| `DB_SERVER_PASSWORD` | `rukovoditel_password` | Database password |
| `DB_SERVER_PORT`     | `3306`                 | Database port     |
| `DB_DATABASE`        | `rukovoditel`          | Database name     |

### Volumes

The following directories are mounted as volumes to persist data:

- `./uploads` - User uploads and attachments
- `./backups` - Database backups
- `./log` - Application logs
- `./tmp` - Temporary files
- `./cache` - Cache files

### Ports

- **Application**: `8080:80` (access at http://localhost:8080)
- **MySQL**: `3307:3306` (for external database access)

## Installation

1. Start the containers:

   ```bash
   docker-compose up -d
   ```

2. Access the installer at http://localhost:8080

3. Follow the installation wizard (database credentials are already configured)

## Management Commands

```bash
# Start containers
docker-compose up -d

# Stop containers
docker-compose down

# Stop and remove volumes (WARNING: deletes all data)
docker-compose down -v

# Restart containers
docker-compose restart

# View logs
docker-compose logs -f app

# Access app container shell
docker-compose exec app bash

# Access MySQL
docker-compose exec mysql mysql -u rukovoditel_user -prukovoditel_password rukovoditel
```

## Updating the Application

```bash
# Rebuild the image
docker-compose build

# Restart with new image
docker-compose up -d
```

## Production Deployment

For production, update `docker-compose.yml`:

1. Change default passwords
2. Use environment files for secrets
3. Configure proper backup strategies
4. Set up reverse proxy (nginx/traefik) for SSL
5. Adjust resource limits

## Troubleshooting

### Permissions Issues

```bash
docker-compose exec app chown -R www-data:www-data /var/www/html
docker-compose exec app chmod -R 755 /var/www/html
```

### Database Connection Issues

```bash
# Check MySQL is running
docker-compose ps

# Check environment variables
docker-compose exec app env | grep DB_
```

### Reset Everything

```bash
docker-compose down -v
rm -rf uploads/* backups/* log/* tmp/* cache/*
docker-compose up -d
```
