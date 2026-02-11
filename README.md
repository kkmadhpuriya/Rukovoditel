# Rukovoditel - Docker Image

![Rukovoditel](https://www.rukovoditel.net/img/logo.png)

This repository provides the source code and Docker image for **Rukovoditel**, an open-source web-based CRM and project management application.

## About Rukovoditel

**Rukovoditel** is a free, open-source web application designer for business that allows you to create and manage CRM systems, project management tools, and custom business applications.

- **Official Website**: [https://www.rukovoditel.net](https://www.rukovoditel.net)
- **Documentation**: [https://docs.rukovoditel.net](https://docs.rukovoditel.net)
- **Forum**: [http://forum.rukovoditel.net](http://forum.rukovoditel.net)
- **License**: GNU GPLv3

### Credits

**Developed by:**

- Sergey Kharchishin
- Olga Kharchishina

This repository is maintained by [kkmadhpuriya](https://github.com/kkmadhpuriya) and provides Docker containerization for easy deployment.

---

## Docker Image

Pre-built Docker images are available on Docker Hub:

🐳 **Docker Hub**: [https://hub.docker.com/r/kkmadhpuriya/rukovoditel](https://hub.docker.com/r/kkmadhpuriya/rukovoditel)

### Supported Platforms

- `linux/amd64`
- `linux/arm64`
- `linux/arm/v7`

### Available Tags

- `kkmadhpuriya/rukovoditel:latest` - Latest stable version
- `kkmadhpuriya/rukovoditel:3.6.4` - Version 3.6.4

---

## Quick Start with Docker

### Using Docker Compose (Recommended)

Create a `docker-compose.yml` file:

```yaml
version: "3.8"

services:
  app:
    image: kkmadhpuriya/rukovoditel:latest
    container_name: rukovoditel-app
    restart: unless-stopped
    ports:
      - "8080:80"
    environment:
      - DB_SERVER=mysql
      - DB_SERVER_USERNAME=rukovoditel_user
      - DB_SERVER_PASSWORD=rukovoditel_password
      - DB_SERVER_PORT=3306
      - DB_DATABASE=rukovoditel
    depends_on:
      mysql:
        condition: service_healthy
    networks:
      - rukovoditel-network

  mysql:
    image: mysql:8.0
    container_name: rukovoditel-mysql
    restart: unless-stopped
    environment:
      - MYSQL_ROOT_PASSWORD=root_password
      - MYSQL_DATABASE=rukovoditel
      - MYSQL_USER=rukovoditel_user
      - MYSQL_PASSWORD=rukovoditel_password
    volumes:
      - mysql-data:/var/lib/mysql
    ports:
      - "3307:3306"
    healthcheck:
      test:
        [
          "CMD",
          "mysqladmin",
          "ping",
          "-h",
          "localhost",
          "-u",
          "root",
          "-proot_password",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - rukovoditel-network
    command: --default-authentication-plugin=mysql_native_password --sql-mode=""

volumes:
  mysql-data:
    driver: local

networks:
  rukovoditel-network:
    driver: bridge
```

Run the application:

```bash
# Start the containers
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the containers
docker-compose down
```

Access the application at: **http://localhost:8080**

### Using Docker Run

```bash
# Pull the image
docker pull kkmadhpuriya/rukovoditel:latest

# Run with environment variables (requires existing MySQL)
docker run -d \
  -p 8080:80 \
  -e DB_SERVER=your_mysql_host \
  -e DB_SERVER_USERNAME=your_username \
  -e DB_SERVER_PASSWORD=your_password \
  -e DB_DATABASE=rukovoditel \
  --name rukovoditel-app \
  kkmadhpuriya/rukovoditel:latest
```

---

## Installation

1. **Start the containers:**

   ```bash
   docker-compose up -d
   ```

2. **Access the installer:**
   Open your browser and navigate to `http://localhost:8080`

3. **Follow the installation wizard:**
   - Database credentials are pre-configured (see docker-compose.yml)
   - Complete the initial setup steps

4. **Login:**
   Use the credentials created during installation

---

## Environment Variables

| Variable             | Description       | Default       |
| -------------------- | ----------------- | ------------- |
| `DB_SERVER`          | Database host     | `localhost`   |
| `DB_SERVER_USERNAME` | Database username | `root`        |
| `DB_SERVER_PASSWORD` | Database password | _(empty)_     |
| `DB_SERVER_PORT`     | Database port     | `3306`        |
| `DB_DATABASE`        | Database name     | `rukovoditel` |

---

## Building from Source

If you want to build the Docker image yourself:

```bash
# Clone the repository
git clone https://github.com/kkmadhpuriya/rukovoditel.git
cd rukovoditel

# Build the image
docker build -t rukovoditel:latest .

# Or build for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t kkmadhpuriya/rukovoditel:latest \
  --push \
  .
```

---

## Features

- ✅ Custom entity builder
- ✅ User access control
- ✅ Reports and dashboards
- ✅ File attachments
- ✅ Email integration
- ✅ Calendar and reminders
- ✅ REST API
- ✅ Multi-language support
- ✅ Plugin system
- ✅ Custom fields and forms

---

## Support

### Rukovoditel Support

- **Forum**: [http://forum.rukovoditel.net](http://forum.rukovoditel.net)
- **Email**: support@rukovoditel.net
- **Documentation**: [https://docs.rukovoditel.net](https://docs.rukovoditel.net)

### Docker Image Issues

For Docker-specific issues with this image, please open an issue on this repository.

---

## License

Rukovoditel is licensed under the **GNU General Public License v3.0**.

See [license.gpl.3.0.txt](license.gpl.3.0.txt) for more details.

- [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)
- [TL;DR Legal](https://www.tldrlegal.com/license/gnu-lesser-general-public-license-v3-lgpl-3)

---

## Additional Resources

- [DOCKER_README.md](DOCKER_README.md) - Detailed Docker documentation
- [DATABASE_SETUP.md](DATABASE_SETUP.md) - Database configuration guide

---

## Acknowledgments

Special thanks to **Sergey Kharchishin** and **Olga Kharchishina** for creating and maintaining Rukovoditel as an open-source project.

---

**Made with ❤️ by [kkmadhpuriya](https://github.com/kkmadhpuriya)**
