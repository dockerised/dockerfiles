# helm

Run Helm in a docker container.

## Setup

* Build the container image.

```
docker build [--no-cache] -t helm .
```

* Create aliases in ~/.bashrc (or your preferred terminal config file)

```
alias helm='docker run --rm -it -e HELM_HOME=/root/.helm -e TILLER_NAMESPACE=helm-system -v ~/.helm:/root/.helm -v ~/.kube:/root/.kube -v ~/.config/gcloud/:/root/.config/gcloud -v `pwd`:/app helm helm '
alias helmconsole='docker run --rm -it -e HELM_HOME=/root/.helm -e TILLER_NAMESPACE=helm-system -v ~/.helm:/root/.helm -v ~/.kube:/root/.kube -v ~/.config/gcloud/:/root/.config/gcloud -v `pwd`:/app helm bash'
alias reckoner='docker run --rm -it -e HELM_HOME=/root/.helm -e TILLER_NAMESPACE=helm-system -v ~/.helm:/root/.helm -v ~/.kube:/root/.kube -v `pwd`:/app helm reckoner '
alias reckonerconsole='docker run --rm -it -e HELM_HOME=/root/.helm -e TILLER_NAMESPACE=helm-system -v ~/.helm:/root/.helm -v ~/.kube:/root/.kube -v `pwd`:/app helm bash'
```

*NOTE:* You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

## Usage

* Run helm.

```
helm help
helm help init
```
