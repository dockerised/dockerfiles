# heroku-cli

Run Heroku CLI in a docker container.

## Setup

* Build the container image.

```
docker build [--no-cache] -t heroku .
```

* Create aliases in ~/.bashrc (or your preferred terminal config file)

```
alias heroku='docker run --rm -it -e HEROKU_API_KEY heroku heroku '
alias herokuconsole='docker run --rm -it -e HEROKU_API_KEY heroku bash'
```

*NOTE:* You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

* Get API key.

Login to heroku.com -> Account settings -> API Key -> Reveal

* Export API key environment variable.

```
export HEROKU_API_KEY='[key]'
```

## Usage

* Run heroku.

```
heroku config -a etisonstaging
```
