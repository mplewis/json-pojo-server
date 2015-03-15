# JSON to POJO Server

Convert your JSON objects to POJOs (Plain Old Java Objects) suitable for serialization by Jackson.

# Basic Usage

## Build the Image

```bash
cd json-pojo-server
docker build .
```

## Run a Fresh Instance

Start a fresh container from the image. This version exposes the server on port 9980:

```bash
docker run -p 9980:80 <your-image-id>
```

## Try It Out

Try sending some JSON:

```bash
curl -X "POST" "http://localhost:9980/" \
    -H "Content-Type: application/json" \
    -d $'{
    "name": "Chappie",
    "rating": 5,
    "characters": [
        {
            "name": "Chappie",
            "human": false
        }, 
        {
            "name": "Yo-Landi",
            "human": true
        }, 
        {
            "name": "Ninja",
            "human": true
        }
    ]
}
'
```

The server will respond with the contents of the generated Java classes:

```json
{
    "RootJsonClass.java": "... contents of RootJsonClass class ...",
    "Character.java": "... contents of Character class ..."
}
```

Take the contents of each, write them into their own .java files, and drop them into your project. You're ready to parse JSON into Java POJOs!

# Advanced Usage

## SSH Into an Instance

Check out phusion/baseimage's instructions to [log into the container via SSH](https://github.com/phusion/baseimage-docker#login_ssh).

# Credits

The JSON to POJO engine is joelittlejohn's [jsonschema2pojo](https://github.com/joelittlejohn/jsonschema2pojo).

This Docker image is based on Phusion's [baseimage-docker](https://github.com/phusion/baseimage-docker).

Built on kkost's [uwsgi-docker](https://github.com/kkost/uwsgi-docker) build script architecture, with lots of help drawn from kkost's [uwsgi-flask](https://github.com/kkost/uwsgi-flask) demo app.

Thanks for all the help. I couldn't have built this without lots of it.


# Contributions

Bug reports, fixes, or features? Feel free to open an issue or pull request any time. You can also tweet me at [@mplewis](http://twitter.com/mplewis) or email me at [matt@mplewis.com](mailto:matt@mplewis.com).

# License

Copyright (c) 2015 Matthew Lewis. Licensed under [the MIT License](http://opensource.org/licenses/MIT).