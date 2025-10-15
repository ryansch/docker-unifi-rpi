#!/bin/bash

set -euo pipefail

STATUS_URL="https://localhost:8443/status"
curl -s --fail --insecure --connect-timeout 1 --max-time 5 "$STATUS_URL"
