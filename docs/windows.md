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

3.  Install required packages:

    ```bash
    pacman -S openssh
    pacman -S rsync
    pacman -S git
    ```

4.  Now you can follow the instructions in [README](../README.md) from step 2
    to clone this repository and configure SSH access.

5.  Download Docker for Windows from https://hub.docker.com/?overlay=onboarding

    You'll need to sign up for an account at hub.docker.com first.

6.  Run the docker installer.

9.  Open a fresh msys shell try `./backup.sh` and `./start.sh` to verify.
