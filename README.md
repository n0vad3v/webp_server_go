<p align="center">
	<img src="./pics/webp_server.png"/>
</p>

**THIS PROJECT IS UNDER DEVELOPMENT, DON'T USE IT ON PRODUCTION ENVIRONMENT.**

After the [n0vad3v/webp_server](https://github.com/n0vad3v/webp_server), I decide to rewrite the whole program with Go, as there will be no more `npm install`s or `docker-compose`s.

This is a Server based on Golang, which allows you to serve WebP images on the fly. 
It will convert `jpg,jpeg,png` files by default, this can be customized by editing the `config.json`.. 

> e.g When you visit `https://a.com/1.jpg`，it will serve as `image/webp` without changing the URL.
>
> For Safari and Opera users, the original image will be used.

## Compare to [n0vad3v/webp_server](https://github.com/n0vad3v/webp_server)

### Size

* `webp_server` with `node_modules`: 43M
* `webp-server(go)` single binary: 15M

### Performance

It's basically between `ExpressJS` and `Fiber`, much faster than the `http` package of course.

### Convenience

* `webp_server`: Clone the repo -> `npm install` -> run with `pm2`
* `webp-server(go)`: Download a single binary -> Run


## General Usage Steps
Regarding the `IMG_PATH` section in `config.json`. 
If you are serving images at `https://example.com/pics/tsuki.jpg` and 
your files are at `/var/www/image/pics/tsuki.jpg`, then `IMG_PATH` shall be `/var/www/image`.

## 1. Download or build the binary
Download the `webp-server` from [release](https://github.com/n0vad3v/webp_server_go/releases) page.

Wanna  build your own binary? Check out [build](#build-your-own-binaries) section

## 2. config file
Create a `config.json` as follows to face your need, default convert quality is 80%.
```json
{
	"HOST": "127.0.0.1",
	"PORT": "3333",
	"QUALITY": "80",
	"IMG_PATH": "/path/to/pics",
	"ALLOWED_TYPES": ["jpg","png","jpeg"]
}
```
## 3. Run
Run the binary like this: `./webp-server --config /path/to/config.json`,
### screen or tmux
Use `screen` or `tmux` to avoid being terminated. Let's take `screen` for example
```
screen -S webp
./webp-server --config /path/to/config.json
```
### systemd
Don't worry, we've got you covered!
```shell script
cp webps.service /lib/systemd/systemd/
systemctl daemon-reload
systemctl enable webps.service
systemctl start webps.service
```
## 4. Nginx proxy_pass
Let Nginx to `proxy_pass http://localhost:3333/;`, and your webp-server is on-the-fly
### WordPress example
```
location ^~ /wp-content/uploads/ {
        proxy_pass http://127.0.0.1:3333;
}
```

## TODO
- [x] This version doesn't support header-based-output, which means Safari users will not see the converted `webp` images, this should be fixed in later releases.
- [ ] Multi platform support.
- [x] A better way to supervise the program.
- [ ] Get rid of render-blocking effect on first render.


## Build your own binaries
Install latest version of golang, enable go module, clone the repo, and then...
```shell script
go build webp-server.go
```
**Due to the limitations of webp module, you can't cross compile this tool. 
But the binary will work instantly on your platform and arch**