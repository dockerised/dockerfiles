# cbsupport

Run cbsupport in a docker container.

## Setup

### Build

* Build the container image.

  ```
  docker build [--no-cache] -t cbsupport .
  ```

### Create Aliases

* Create aliases in ~/.bashrc (or your preferred terminal config file)

  ```
  alias cbsupportconsole='docker run --rm -it -v ~/tmp/cbsupport:/root/tmp -v ~/.config/cbsupport:/root/.cbsupport -v ~/.kube:/root/.kube -v ~/.config/gcloud/:/root/.config/gcloud -v `pwd`:/app --name cbsupport cbsupport bash'
  ```

*NOTE:* You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

### Initialize

* Create local cbsupport config directory.

  ```
  mkdir ~/tmp/cbsupport
  mkdir ~/.config/cbsupport
  ```

* Initialize config, and smoke test cbsupport.  It will prompt you for:
  * A master password for cbsupport to encrypt your credentials locally.
  * A user.  This is your github account.
  * An API token.  Use the following process to create the API token.  https://support.cloudbees.com/hc/en-us/articles/115003090592#creatingatokenfromtheui

  ```
  cbsupport check
  ```

## Usage

* See cbsupport version.

  ```
  cbsupport version
  ```

* Gather information for Cloudbees Support.  Typically, they'll tell you which specific command to run.  For general use, pull default info.

  ```
  cbsupport required-data default
  ```

## References

https://cbsupport-docs.cloudbees.com/#_setup
https://support.cloudbees.com/hc/en-us/articles/115003090592
