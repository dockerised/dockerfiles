# ops-dockerfiles

Alias examples from amcmanus

```
alias aws='docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION awscli aws '
alias awsconsole='docker run -it --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION awscli bash'
alias heroku='docker run --rm -it -e HEROKU_API_KEY heroku heroku '
alias herokuconsole='docker run --rm -it -e HEROKU_API_KEY heroku bash'
```

Other good docker images:

Postgres: jbergknoff/postgresql-client
Example: docker run -it --rm jbergknoff/postgresql-client postgresql://USER:PASSWORD@HOSTNAME:5439/DATABASE

MySQL: mysql:VERSION
Example: docker run --rm -it mysql:5.6 bash
