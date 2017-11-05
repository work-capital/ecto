#!/bin/sh
set -e

echo "ecto:"
(cd ecto && mix deps.get && mix test --exclude repo --exclude adapter)
echo

echo "ecto_repo:"
(cd ecto_repo && mix deps.get && mix test && MIX_ENV=pg mix test)
