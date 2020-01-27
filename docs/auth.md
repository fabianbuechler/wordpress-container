# Configure Authentication with Hosting

While this uses easyname simple hosting as example, this generally works with
any shared Wordpress hosting that allows SSH access and uses MySQL or MariaDB as
database.

## Enable SSH Access to easyname hosting

In order for `backup.sh` to be able to connect to the hosting server,
configure SSH access.

1.  Log in to the easyname controlpanel at:
    https://my.easyname.at/de/hosting/ssh

2.  Configure an SSH access password ("SSH Zugang") and note hostname,
    username and password, refered to later as `{SSH_HOST}`, `{SSH_USER}` and
    `{SSH_PASSWORD}`.

## Enable SSH authentication with keys:

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
    eval `ssh-agent -s`
    ssh-add ./id_ed25519
    # Enter the password you chose before
    ```

3.  Upload the public key to your easyname host:

    ```bash
    # starting ssh-agent is only required once
    ssh-copy-id -i ./id_ed25519 user@host
    # Will ask for the SSH password configured before
    ```

4.  Ensure SSH access works by logging in:

    ```bash
    ssh user@host
    # This should display the remote shell prompt, like
    {SSH_USER}:~$
    ```
