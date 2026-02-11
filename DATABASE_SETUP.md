# Database Setup

## Environment Configuration

The database configuration has been modernized to use environment variables for better security.

### Files Created

1. **`.env`** - Your local environment configuration (not committed to git)
2. **`.env.example`** - Template for environment variables
3. **`config/database.php`** - Database configuration that reads from `.env`
4. **`.gitignore`** - Excludes sensitive files from version control

### Configuration Steps

1. **Update `.env` file** with your database credentials:

   ```env
   DB_SERVER=localhost
   DB_SERVER_USERNAME=your_username
   DB_SERVER_PASSWORD=your_password
   DB_SERVER_PORT=3306
   DB_DATABASE=rukovoditel
   ```

2. **Create the database** (if not already created):

   ```bash
   mysql -u root -p
   CREATE DATABASE rukovoditel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

3. **Access the installer** by visiting your Rukovoditel URL in a browser. The application will automatically run the installation wizard.

### Environment Variables

| Variable             | Description       | Default       |
| -------------------- | ----------------- | ------------- |
| `DB_SERVER`          | Database host     | `localhost`   |
| `DB_SERVER_USERNAME` | Database username | `root`        |
| `DB_SERVER_PASSWORD` | Database password | _(empty)_     |
| `DB_SERVER_PORT`     | Database port     | `3306`        |
| `DB_DATABASE`        | Database name     | `rukovoditel` |

### Security Notes

- The `.env` file is excluded from git to protect sensitive credentials
- Never commit the actual `.env` file to version control
- Use `.env.example` as a template for team members
- Make sure `config/database.php` has proper file permissions (not world-readable in production)
