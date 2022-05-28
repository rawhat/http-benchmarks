#!/usr/bin/env bash

python -m gunicorn -w 16 -b 0.0.0.0:8080 app:app
