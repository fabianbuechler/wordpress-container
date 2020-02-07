# Wordpress Container from Hosting Backup

## How to use

### `backup.sh`

Backup Wordpress content and database from hosting and synchronize it with
`data/wp-content/` and `data/db-backup/` directories.

In order for `backup.sh` to work, please configure authentication with
the hosting server as described below.

Remember to load your SSH key [as configured](./docs/auth.md) using
`ssh-add ./id_ed25519`.

### `start.sh`

Run the Wordpress and database containers.

- Wordpress: http://localhost:8080/
- Wordpress admin: http://localhost:8080/wp-admin/

### `stop.sh`

Stop and clean up the containers.


## Configuration

The scripts are configured via an environment file `.env`.

1.  If you want to use this on Windows, follow the
    [how to use on Windows](./docs/windows.md) guide

2.  Clone this repository to any directory on your system, and install script
    requirements into a virtualenv:

    ```bash
    # If you want the repository to be cloned to ~/git/wordpress-container
    mkdir ~/git
    cd git
    git clone https://github.com/fabianbuechler/wordpress-container.git
    cd wordpress-container
    mkvirtualenv -p python3 wpc
    (wpc) pip install pip-tools
    (wpc) pip-tools sync
    ```

3.  [Configure authentication with your hosting](./docs/auth.md) for backup
    script.

4.  Configuring Server and Wordpress Versions

    To configure versions of Wordpress, PHP and MariaDB used in Docker images,
    set the three respective `VERSION_*` variables in the `.env` file (in this
    directory):

    ```ini
    VERSION_WORDPRESS=5.3.2
    VERSION_PHP=7.3
    VERSION_MARIADB=10.1
    ```

5.  Configure environment for Backup Sync Script

    In the `.env` file in this directory, add variables for SSH host and user,
    Wordpress installation directory and MySQL database like:

    ```ini
    SSH_HOST=e12345-ssh.services.easyname.eu
    SSH_USER=e12345
    WORDPRESS_DIR=/data/web/e12345/html/apps/wordpress-54321
    WORDPRESS_TABLE_PREFIX=abcd_
    MYSQL_DATABASE=u987654
    ```

    Also, create a file `mysql.cnf` in this directory, that contains the MySQL
    database user and password like:

    ```ini
    [mysqldump]
    user=u987654
    password=abcdefgh
    ```
