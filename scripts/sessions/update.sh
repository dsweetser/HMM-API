#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/sessions/${ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --data '{
    "session": {
      "game_id": "'"${GAME}"'",
      "user_id": "'"${USER}"'",
      "rating": "'"${RATING}"'",
      "players": "'"${PLAYERS}"'"
    }
  }'
#  --header "Authorization: Token token=$TOKEN"

echo
