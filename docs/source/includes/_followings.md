# Followings

## List Followings for a specific User
```http
GET /api/v1/users/1/links/followings HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 200 OK
Content-Length: 4567
{
  "following":[
    {
      "id":1,
      "email":"example-88@railstutorial.org",
      "name":"Kenna Ondricka",
      "activated":true,
      "created_at":"2015-01-13T20:35:47Z",
      "updated_at":"2015-02-02T22:09:50Z",
      "micropost_ids":[],
      "following_ids":[],
      "follower_ids":[]
    },
    {
      "id":1,
      "email":"example-89@railstutorial.org",
      "name":"Della Oberbrunner PhD",
      "activated":true,
      "created_at":"2015-01-13T20:35:47Z",
      "updated_at":"2015-02-02T22:09:50Z",
      "micropost_ids":[],
      "following_ids":[],
      "follower_ids":[]
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

You can GET all users followings in /api/v1/users/:id/followings.
It doesn't require authentication.


## Update Followings for a User
```http
PUT /api/v1/users/1/followings HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/json

{
  "following_ids": [2,3,4,5,6,7]
}
```
```http
HTTP/1.1 204 OK
Content-Length: 4567
```

You can update a user's followings sending a POST to `/api/v1/users/:id/followings` with the following_ids.

## Get a user's following
```http
GET /api/v1/users/1/followings/2 HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 204 OK
```
It actually helps you figure out if a user if a following for another user or not.
If the following you check is not a following to the user then you get back a 404.

## Create a Follower for a User
```http
POST /api/v1/users/1/followings/2 HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/json
```
```http
HTTP/1.1 200 OK
```
If the following is already there you get back a 304.


## Destroy a User
```http
DELETE /api/v1/users/1/links/followings/2 HTTP/1.1
User-Agent: MyClient/1.0.0
Accept: application/json
```

If the following has already been deleted or was never there you get back a 304.

