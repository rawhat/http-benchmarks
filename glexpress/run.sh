#!/usr/bin/env bash

# non-cluster:
# NODE_ENV=production node index.js

# cluster
npx pm2 start index.js -i 16 --env production
