# docker-haproxy-simple

HAProxy in a container, with simple setup using environment variables.

## Usage

### Build

    $ docker build -t haproxy-simple .

### Run

Typically:

    $ docker run -itd \
        -p 8877:80
        -e BACKEND_HOSTS='icanhazip1 64.182.208.181,icanhazip2 64.182.208.182' \
          haproxy-simple

#### Runtime Environment Variables

There should be a reasonable amount of flexibility using the available variables. If not please raise an issue so your use case can be covered!

- FRONTEND_PORT - the port to listen on e.g. `80`
- BACKEND_HOSTS - the hosts in the backend pool, e.g.
  `host1 1.2.3.4:80,host2 1.2.3.5.80,host3 1.2.3.6`

### Tag and Push

    $ docker tag -f haproxy-simple flaccid/haproxy-simple
    $ docker push flaccid/haproxy-simple

License and Authors
-------------------
- Author: Chris Fordham (<chris@fordham-nagy.id.au>)

```text
Copyright 2016, Chris Fordham

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
