#!/bin/bash

APP_NAME="to-do-app"
DIRECTORY_HOME="/home/${USER}"
DIRECTORY_APP="${DIRECTORY_HOME}/${APP_NAME}"
DIRECTORY_VENV="${DIRECTORY_APP}/venv"

# Changing directory
cd "$DIRECTORY_APP"

# Creating the virtual environment
if [ ! -d "$DIRECTORY_VENV" ]; then
	python3 -m venv venv
fi

# Activating the virtual environment
. venv/bin/activate

# Install python libraries
pip install -r requirements.txt

# Restarting flask app service
sudo systemctl restart flaskapp.service
