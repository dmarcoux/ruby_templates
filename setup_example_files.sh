#!/usr/bin/env bash
# Setup example files in the config directory after cloning this project's git repository

ROOT_GIT_REPO="$(git rev-parse --show-toplevel)"

for example_file in "$ROOT_GIT_REPO"/config/*.example; do
  cp "$example_file" "$ROOT_GIT_REPO"/config/"$(basename "$example_file" .example)"
done
