# dgctl - Digger docker file

http://digger.dev/

```bash
cd digger-ctl
docker build -t digger-ctl .
docker run -it -e AWS_PROFILE=$AWS_PROFILE -v ~/.aws:/root/.aws:ro -v `pwd`:/app -it digger-ctl dgctl init
```