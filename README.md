This is the readme for the API of How Many Meeples, an app for logging your plays of board games.  This app was constructed using Ruby on Rails using a base template provided by General Assembly.  I created my ERD, with the biggest focus being on the join table sessions, since that's the main focus of the app.  I learned about the way rails operates, and was amazed by how much it does automatically.  I had to struggle with getting my OpenReadController functionality working properly without passing a user_id.  I came up with a workaround that would allow only the user who created the session to alter the user_id.  I ultimately had to step away for a while and come back with fresh eyes (and some encourage advice from friends) in order to get it working correctly.

In the future I'd like to define a custom method for sesions that will return only the sessions from a single user.  Additionally, I'd like to create a column within the games table of all the sessions that reference that game and use that data to create average scores across all users for each game.

### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

#### POST /sign-up

Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
ID=1 OLDPW=hannah NEWPW=elle TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl http://localhost:4741/sign-out/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 2,
    "email": "bob@ava.com"
  }
}
```

### GAMES TABLE

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
|  GET   | `/games`               | `games#index`     |
|  GET   | `/games/:id`           | `games#show`      |
|  POST  | `/games/`              | `games#create`    |

### GET /games

Returns an index of all the games users have created.  No Authentication required.

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
  ```

  response:
  ```md
  HTTP/1.1 200 OK
  Content-Type: application/json; charset=utf-8

  {
    "games": [
      {
        "id": 1,
        "name": "Splendor"
      },
      {
        "id": 2,
        "name": "Caverna"
      }
    ]
  }
  ```

### GET /games/:id

Returns a single game id. No Authentication required.

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/games/${ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request GET
  ```


response:
```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "games": [
    {
      "id": 1,
      "name": "Splendor"
    }
  ]
}
```

### POST /games

Creates a game and returns json with the game created. Requires authentication.

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/games/"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "game": {
      "name": "'"${NAME}"'"
    }
  }'
```

```md
HTTP/1.1 201 Created
{
  "game": {
    "id":13,
    "name":"Carcassonne"
  }
}
```

### SESSION TABLE

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
|  GET   | `/sessions`            | `sessions#index`  |
|  POST  | `/sessions/`           | `sessions#create` |
| PATCH  | `/sessions/:id`        | `sessions#create` |
| DELETE | `/sessions/:id`        | `sessions#destroy`|

### GET /sessions
Returns a JSON index of all the sessions users have created.  No Authentication required.

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/sessions/"
curl "${API}${URL_PATH}" \
  --include \
  --request GET \
  ```

response
```md
HTTP/1.1 200 OK
{
  "sessions":[
    {
      "id":2,
      "players":2,
      "rating":5,
      "notes":null,
      "user":4,
      "editable":false,
      "game":
      {
        "id":4,
        "name":"Takenoko"
      }
    }
    ...
  ]
}
```

### POST /sessions/

Creates a new session with the current user's ID. Requires authentication token from the creator, game_id, and a rating.  Returns a JSON string for the created session.

```sh
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
      "rating": "'"${RATING}"'",
      "players": "'"${PLAYERS}"'",
      "notes": "'"${NOTES}"'"
    }
  }'
  ```

  response
  ```md
HTTP/1.1 201 Created
{
  "session":
    {
    "id":41,
    "players":2,
    "rating":4,
    "notes":"",
    "user":5,
    "editable":true,
    "game":
      {
      "id":2,
      "name":"Caverna"
      }
    }
  }
```

### PATCH /sessions/:id

Updates a session. Requires authentication token from the sessions creator, game_id, and a rating.  Returns a JSON string for the updated session.

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/sessions/${ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
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
  ```

  response
  ```md
  HTTP/1.1 200 OK
  {
    "session":
      {
      "id":41,
      "players":2,
      "rating":4,
      "notes":"dude why didn't I put notes in before!?!?!?",
      "user":5,
      "editable":true,
      "game":
        {
        "id":2,
        "name":"Caverna"
        }
      }
    }
  ```

  ### DESTROY sessions/:id

  Destroys a session. Requires id and authorization token from the original creator of the session.  Returns no content.

  ```sh
  API="${API_ORIGIN:-http://localhost:4741}"
  URL_PATH="/sessions/${ID}"
  curl "${API}${URL_PATH}/" \
    --include \
    --request DELETE \
    --header "Content-Type: application/json" \
    --header "Authorization: Token token=$TOKEN"
  ```

  response
  ```md
  HTTP/1.1 204 No Content
  ```
