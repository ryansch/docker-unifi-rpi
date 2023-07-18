#!/bin/bash

set -euo pipefail

STATUS_URL="http://localhost:8080/status"
curl -s --fail --connect-timeout 1 --max-time 5 "$STATUS_URL"
