#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/games/${ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "game": {
      "name": "'"${NAME}"'"
    }
  }'

echo
