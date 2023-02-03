# docker-jekyll

Dockerfile of [jekyll/jekyll](https://github.com/jekyll/jekyll)

This repository is adapted from [envygeeks/jekyll-docker](https://github.com/envygeeks/jekyll-docker).  
The main purpose of this repository is to build the docker image for amd64/arm64.

## Usage

### Build docker image

```sh
JEKYLL_VERSION=4.2.2
./build.sh
```

### Launch docker container in the Jekyll project

```sh
JEKYLL_VERSION=4.2.2
docker run --rm --volume="$PWD:/srv/jekyll" -p 4000:4000 tiryoh/jekyll:$JEKYLL_VERSION jekyll serve --config _config.yml
```

## License

(C) 2021-2023 Daisuke Sato

This repository is licensed under the MIT License, see [LICENSE](./LICENSE).
Unless attributed otherwise, everything in this repository is licensed under the MIT license.

### Acknowledgements

This repository is adapted from [envygeeks/jekyll-docker](https://github.com/envygeeks/jekyll-docker).

```
Copyright (c) 2015-2020 Jordon Bedwell

Permission to use, copy, modify, and/or distribute this software for
any purpose with or without fee is hereby granted, provided that the
above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING
OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```