#!/usr/bin/env bash

set -euo pipefail

sed ':a;N;$!ba;s/\n/\\n\\\n\\/g'
