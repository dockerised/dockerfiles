# dgctl - Digger docker file

http://digger.dev/

docker run -it -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION -v ~/.aws:/root/.aws:ro -v `pwd`:/app -it digger-ctl dgctl init