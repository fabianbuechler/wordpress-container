# How to use on Windows

To use this on Windows, a shell, SSH, rsync and git are required. This can be
achieved using MSYS2 and installing the packages `openssh`, `rsync` and `git`
using `pacman`.

1.  Download MSYS2 from https://www.msys2.org/, run the installer and follow
    the instructions. Then start msys shell.

2.  Update pacman sources:

    ```bash
    pacman -Syu
    # Then close msys shell, reopen it and
    pacman -Su
    ```

3.  Install required packages via the pacman package manager provided by msys2:

    ```bash
    pacman -S openssh rsync git python
    ```

4.  Download Docker for Windows from https://hub.docker.com/?overlay=onboarding

    You'll need to sign up for an account at hub.docker.com first.

5.  Run the docker installer.

6.  Now you can clone this repository and install script requirements:

    ```bash
    cd ~/path/where/this/should/be/cloned
    git clone https://github.com/fabianbuechler/wordpress-container.git
    cd wordpress-container
    python -m ensurepip
    python -m pip install pip-tools
    python -m piptools sync
    ```

6.  Then, follow the instructions in README to configure SSH access.

8.  Now follow the [other setup steps](../README.md) and then ...

9.  Open a fresh msys shell try `./backup.sh` and `./start.sh` to verify.
