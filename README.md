# Elixir programming assignment
We want you to build an application in Elixir that will:
- Display a list of jokes from the Chuck Norris API (https://api.chucknorris.io/#!)
- Allows a user to favourite jokes.
- Allows a user to retrieve their favourite jokes.
- Allows a user to share his favourited jokes with another user.

The only requirements other than the functionality above are:
- All actions should be accessible through HTTP, this does not mean it needs a
visual interface, an API is fine too.
- You should not use an external database, but you should store favourites on the
server.

The goal of this assignment is to:
- have a common technical solution to talk about during the technical interview
- give us an idea about your skills
- give us insight in how you’d approach a task

You should spend about 4 hours on this assignment (you are free to take longer, but
let us know how much time you’ve spent). Make sure you deliver the assignment as
working software and that it’s a representation of your usual work. We will give you
some time during the interview to demonstrate your assignment and tell us how you
went about building it.

## demo

### Get a list of jokes

```shell
curl --request GET \
--url 'http://localhost:4000/api/jokes?name=bob'
```

```json
{
	"jokes": {
		"fav": [],
		"random": [
			{
				"categories": [],
				"created_at": "2020-01-05 13:42:21.179347",
				"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
				"id": "WLb0v6k8TDCuZFJt2PRNHQ",
				"updated_at": "2020-01-05 13:42:21.179347",
				"url": "https://api.chucknorris.io/jokes/WLb0v6k8TDCuZFJt2PRNHQ",
				"value": "Chuck Norris kills time. With two meat cleavers."
			},
			{
				"categories": [],
				"created_at": "2020-01-05 13:42:28.664997",
				"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
				"id": "1KQ9RXVhQUax3PaCl2S7pg",
				"updated_at": "2020-01-05 13:42:28.664997",
				"url": "https://api.chucknorris.io/jokes/1KQ9RXVhQUax3PaCl2S7pg",
				"value": "Chuck Norris taught spongebob how to make a camp fire. Underwater."
			},
			{
				"categories": [],
				"created_at": "2020-01-05 13:42:25.905626",
				"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
				"id": "P6d7oYy5TtevElVDw3Jngw",
				"updated_at": "2020-01-05 13:42:25.905626",
				"url": "https://api.chucknorris.io/jokes/P6d7oYy5TtevElVDw3Jngw",
				"value": "Hfkeheodicijhahkfooviysgjroiuchhsvfjshdfgvf Chuck Norris"
			}
		],
		"shared": []
	}
}
```
### Add a favourite

```shell
curl --request POST \
  --url 'http://localhost:4000/api/fav?name=bob' \
  --header 'Content-Type: application/json' \
  --data '{
	"id": "WLb0v6k8TDCuZFJt2PRNHQ"
}'
```

```json
{
	"favs": [
		{
			"categories": [],
			"created_at": "2020-01-05 13:42:21.179347",
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"id": "WLb0v6k8TDCuZFJt2PRNHQ",
			"updated_at": "2020-01-05 13:42:21.179347",
			"url": "https://api.chucknorris.io/jokes/WLb0v6k8TDCuZFJt2PRNHQ",
			"value": "Chuck Norris kills time. With two meat cleavers."
		}
	]
}
```

### Share a favourite
Make sure the receiver of the joke has seen their list of jokes so the system knows their name.

```shell
curl --request POST \
  --url 'http://localhost:4000/api/share?name=bob' \
  --header 'Content-Type: application/json' \
  --data '{
	"id": "WLb0v6k8TDCuZFJt2PRNHQ",
	"share_with": "alice"
}'
```
Result from Alice list:
```json
{
	"jokes": {
		"fav": [],
		"random": [
          // ...
		],
		"shared": [
			{
				"categories": [],
				"created_at": "2020-01-05 13:42:22.089095",
				"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
				"id": "hhITgBqTQgOwYlDfhjCWPg",
				"updated_at": "2020-01-05 13:42:22.089095",
				"url": "https://api.chucknorris.io/jokes/hhITgBqTQgOwYlDfhjCWPg",
				"value": "Check yourself before you wreck yourself....... Cos roundhouse kicks from Chuck Norris is bad for your health."
			}
		]
	}
}
```