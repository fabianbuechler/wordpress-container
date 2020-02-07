#!/usr/bin/env bash
python -m venv .venv
. .venv/bin/activate
pip install pip-tools
pip-sync
