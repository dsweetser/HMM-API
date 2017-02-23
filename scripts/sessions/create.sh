#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/sessions/"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "session": {
      "game_id": "'"${GAME}"'",
      "user_id": "'"${USER}"'",
      "rating": "'"${RATING}"'",
      "players": "'"${PLAYERS}"'",
      "notes": "'"${NOTES}"'"
    }
  }'


echo
