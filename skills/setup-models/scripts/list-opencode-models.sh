#!/usr/bin/env bash
# Prints each model OpenCode can use as `provider/model<TAB>variant,variant`.
# Filters /api/model through jq because the raw response includes provider settings such as API keys.
set -euo pipefail

opencode api get /api/model \
  | jq -r '.data[] | "\(.providerID)/\(.id)\t\([.variants[]?.id] | join(","))"' \
  | sort
