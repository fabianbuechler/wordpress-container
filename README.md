# Wordpress Container from easyname Hosting Backup

## Creating a Backup

Run `sync_backup.sh` to backup Wordpress content and database from easyname and
synchronize it with `data/wp-content/` and `data/db-backup/` directories.

In order for `sync_backup.sh` to work, please configure authentication with the
easyname hosting server as described below.

## Configure Authentication with easyname Hosting

### Enable SSH Access to easyname hosting

In order for `sync_backup.sh` to be able to connect to the hosting server,
configure SSH access.

1.  Log in to the easyname controlpanel at:
    https://my.easyname.at/de/hosting/ssh

2.  Configure an SSH access password ("SSH Zugang") and note hostname,
    username and password, refered to later as `{SSH_HOST}`, `{SSH_USER}` and
    `{SSH_PASSWORD}`.

### Enable SSH authentication with keys:

For a more secure connection without the need to enter the SSH password multiple
times during each backup sync, you need to generate a SSH key pair and upload
the public key to the hosting server.

1.  Create an SSH key pair:

    ```bash
    ssh-keygen -t ed25519 -b 4096 -C "your@email.com" -f ./id_ed25519
    # Then choose a password for the key
    ```

2.  Load the SSH key into your key agent:

    ```bash
    ssh-add ./id_ed25519
    # Enter the password you chose before
    ```

3.  Upload the public key to your easyname host:

    ```bash
    ssh-copy-id -i ./id_ed25519 user@host
    # Will ask for the SSH password configured before
    ```

4.  Ensure SSH access works by logging in:

    ```bash
    ssh user@host
    # This should display the remote shell prompt, like
    {SSH_USER}:~$
    ```

### Configure environment for Backup Sync Script

1.  Create a file `hosting.env` in this directory, that contains SSH host and
    user, Wordpress installation directory and MySQL database like:

    ```ini
    SSH_HOST=e12345-ssh.services.easyname.eu
    SSH_USER=e12345
    WP_DIR=/data/web/e12345/html/apps/wordpress-54321
    MYSQL_DATABASE=u987654
    ```

2.  Create a file `mysql.cnf` in this directory, that contains the MySQL
    database user and password like:

    ```ini
    [mysqldump]
    user=u987654
    password=abcdefgh
    ```
