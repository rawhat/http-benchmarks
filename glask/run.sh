#!/usr/bin/env bash

python -m gunicorn -w 6 app:app
