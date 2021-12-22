# pluto

Run Pluto in a docker container.

## Setup

* Build the container image.

```
docker build [--no-cache] -t pluto .
```

* Create aliases in ~/.bashrc (or your preferred terminal config file)

```
alias pluto='docker run --rm -it -v ~/.kube:/root/.kube -v `pwd`:/app pluto pluto'
alias plutoconsole='docker run --rm -it -v ~/.kube:/root/.kube -v `pwd`:/app pluto bash'
```

*NOTE:* You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

## Usage

* Run pluto.

```
pluto help
pluto help detect-helm
```
