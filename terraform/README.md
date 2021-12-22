# terraform

Run Terraform in a docker container.

## Setup

* Build the container image.

```
docker build [--no-cache] -t terraform .
```

* Create aliases in ~/.bashrc (or your preferred terminal config file)

```
alias terraform='docker run --rm -it -e GOOGLE_ENCRYPTION_KEY -e DATADOG_API_KEY -e DATADOG_APP_KEY -e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/application_default_credentials.json -v ~/.config/gcloud:/root/.config/gcloud -v ~/.terraform.d:/root/.terraform.d -v ~/.ssh/[github_private_key]:/root/.ssh/id_rsa -v `pwd`:/app terraform terraform '
alias terraformconsole='docker run --rm -it -e GOOGLE_ENCRYPTION_KEY -e DATADOG_API_KEY -e DATADOG_APP_KEY -e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/application_default_credentials.json -v ~/.config/gcloud:/root/.config/gcloud -v ~/.terraform.d:/root/.terraform.d -v ~/.ssh/[github_private_key]:/root/.ssh/id_rsa -v `pwd`:/app terraform bash'
```

*NOTE:* You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

* Get API keys.

  * GOOGLE_ENCRYPTION_KEY

    *NOTE:* There are different keys for Staging (Working) and Production.

    LastPass -> Shared-DevOps -> Terraform [PR|Staging|Production] Google Encryption Key

  * DATADOG_API_KEY

    Login to https://app.datadoghq.com/account/settings#api -> API Keys -> confluent_key

  * DATADOG_APP_KEY

    Login to https://app.datadoghq.com/account/settings#api -> Application Keys -> terraform-testing-jen

* Export API key environment variable.

```
export DATADOG_API_KEY='[key]'
export DATADOG_APP_KEY='[key]'
export GOOGLE_ENCRYPTION_KEY='[key]'
```

* Initialize.

  * Create local terraform config directory.

  ```
  mkdir ~/.terraform.d
  ```

## Usage

* Run terraform.

```
terraform -help
terraform -help init
cd inventory/*/terraform
terraform init
```
