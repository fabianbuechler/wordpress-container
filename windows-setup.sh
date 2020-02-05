#!/usr/bin/env bash
pacman -S openssh rsync git python
python -m ensurepip
python -m pip install pip-tools
python -m piptools sync
