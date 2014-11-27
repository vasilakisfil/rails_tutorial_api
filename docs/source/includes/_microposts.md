# Microposts

## List Microposts
```http
GET /api/v1/microposts HTTP/1.1
Micropost-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "microposts":[
    {
      "id":1,
      "content":"A simple micropost",
      "picture": null,
      "created_at":"2015-01-13T20:35:47Z",
      "updated_at":"2015-02-02T22:09:50Z",
      "user_id":1
    },
    {
      "id":2,
      "content":"Another simple micropost",
      "picture": null,
      "created_at":"2015-01-13T20:35:47Z",
      "updated_at":"2015-02-02T22:09:50Z",
      "user_id":1
    }
  ],
  "meta":{
    "current_page":1,
    "next_page":2,
    "prev_page":null,
    "total_pages":10,
    "total_count":300
  }
}
```

You can GET all microposts in /api/v1/microposts.
`user_id` is required.
You can filter by any attribute.
More on the index micro-API [here](https://github.com/kollegorna/active_hash_relation).
Also, if you pass in `feed=true` then you get the feed for user with `user_id`.
It doesn't require authentication.


## Create a Micropost
```http
POST /api/v1/microposts HTTP/1.1
Micropost-Agent: MyClient/1.0.0
Accept: application/json

{
  "micropost": {
    "content":"A simple micropost",
    "user_id":1
  }
}
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "micropost": {
    "id":1,
    "content":"A simple micropost",
    "picture": null,
    "created_at":"2015-01-13T20:35:47Z",
    "updated_at":"2015-02-02T22:09:50Z",
    "user_id":1
  }
},
```

You can create a new micropost sending a POST to `/api/v1/microposts` with the necessary attributes.
A micropost object should at least include, content and a `user_id`.
A user can create only micropost with her own `user_id`.

## Show a Micropost
```http
GET /api/v1/microposts/1 HTTP/1.1
Micropost-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "micropost": {
    "id":1,
    "content":"A simple micropost",
    "picture": null,
    "created_at":"2015-01-13T20:35:47Z",
    "updated_at":"2015-02-02T22:09:50Z",
    "user_id":1
  }
},
```
You can retrieve a micropost's info by sending a GET request to `/api/v1/microposts/{id}`.


## Update a Micropost
```http
PUT /api/v1/microposts/1 HTTP/1.1
Micropost-Agent: MyClient/1.0.0
Accept: application/json
{
  "micropost": {
    "content":"An updated content",
  }
}
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "micropost": {
    "id":1,
    "content":"An updated content",
    "picture": null,
    "created_at":"2015-01-13T20:35:47Z",
    "updated_at":"2015-02-02T22:09:50Z",
    "user_id":1
  }
},
```
You can update a micropost's attributes by sending a PUT request to `/api/v1/microposts/{id}` with the necessary attributes.


## Destroy a Micropost
```http
DELETE /api/v1/microposts/1 HTTP/1.1
Micropost-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "micropost": {
    "id":1,
    "content":"An updated content",
    "picture": null,
    "created_at":"2015-01-13T20:35:47Z",
    "updated_at":"2015-02-02T22:09:50Z",
    "user_id":1
  }
},
```

You get back the deleted micropost.
