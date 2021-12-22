# gcloud

Run Google Cloud SDK (gcloud), Kubernetes CLI (kubectl), and GCP Cloud Storage CLI (gsutil) in a docker container.

## Build

* Build the container image.

  ```
  docker build [--no-cache] -t gcloud .
  ```

## Access Container Applications

In order to use the applications in your docker containers, you need to make them accessible to your host system.  Aliases are the simplest approach, but they have their limitations.  For example, they can't (easily) be used in Makefiles and scripts.  Shell script wrappers are (slightly) more complex, but they are far more versatile.

The "console" versions of these scripts--e.g., `gcloudconsole` and `kubectlconsole`--can be done as aliases, since they're only used interactively.  For the "non-console" versions--e.g., `gcloud` and `kubectl`, choose one of the following but not both.

### Create Aliases

* Create aliases in `~/.bashrc` (or your preferred terminal config file)

  ```
  alias gcloud='docker run --rm -it -v ~/.config/gcloud/:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v ~/.config/gcloud_ssh:/root/.ssh gcloud gcloud '
  alias gcloudconsole='docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v ~/.config/gcloud_ssh:/root/.ssh gcloud bash'
  alias kubectl='docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v `pwd`:/app gcloud kubectl '
  alias kubectlconsole='docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v `pwd`:/app gcloud bash'
  alias gsutil='docker run --rm -it -e GOOGLE_ENCRYPTION_KEY -v ~/.config/gcloud:/root/.config/gcloud -v `pwd`:/app gcloud gsutil -o "GSUtil:encryption_key=${GOOGLE_ENCRYPTION_KEY}" '
  alias gsutilconsole='docker run --rm -it -e GOOGLE_ENCRYPTION_KEY -v ~/.config/gcloud:/root/.config/gcloud -v `pwd`:/app gcloud bash'
  ```

  **NOTE:** You will need to either open a new terminal or `source ~/.bashrc` in an already opened terminal to
gain access to the new aliases.

### Create Simple Shell Script Wrappers.

Create simple shell scripts instead of aliases.  This is really only useful/necessary for commands like `gcloud` and `kubectl`, but you could create it for the `*console` versions, too, if you wished.

* Create `/usr/local/bin/gcloud` containing the following:

  ```
  #!/bin/bash

  docker run --rm -it -v ~/.config/gcloud/:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v ~/.config/gcloud_ssh:/root/.ssh gcloud gcloud "$@"
  ```

* Make `/usr/local/bin/gcloud` executable.

  ```
  chmod u+x /usr/local/bin/gcloud
  ```

* Create `/usr/local/bin/kubectl` containing the following:

  ```
  #!/bin/bash

  docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v `pwd`:/app gcloud kubectl "$@"
  ```

* Make `/usr/local/bin/kubectl` executable.

  ```
  chmod u+x /usr/local/bin/kubectl
  ```

* Create `/usr/local/bin/gsutil` containing the following:

  ```
  #!/bin/bash

  docker run --rm -it -e GOOGLE_ENCRYPTION_KEY -v ~/.config/gcloud:/root/.config/gcloud -v `pwd`:/app gcloud gsutil -o "GSUtil:encryption_key=${GOOGLE_ENCRYPTION_KEY}" "$@"
  ```

* Make `/usr/local/bin/gsutil` executable.

  ```
  chmod u+x /usr/local/bin/gsutil
  ```

## Initialize

  * Create local gcloud config directory.

  ```
  mkdir ~/.config/gcloud
  mkdir ~/.config/gcloud_ssh/
  mkdir ~/.kube
  mkdir ~/.docker
  ```

  * Authorize, and configure your gcloud instance.

  ```
  gcloud init --console-only
  ```

  You will be prompted to navigate to a URL, log in, and then paste a verification code.  After
  that, select an existing project to begin with.

  * Authorize remote gcloud Docker registries.

  ```
  gcloud auth configure-docker
  ```

## Usage

* Run gcloud.

  https://cloud.google.com/sdk/gcloud/reference/

  ```
  gcloud config list
  gcloud projects list
  gcloud projects create [Project ID]
  gcloud config set project [Project ID]
  ```

* Run kubectl.

  ```
  kubectl help
  ```

* Use remote GCP docker image repository.

**NOTE:** There are some negative security implications to this.  Use at your own risk.

**NOTE:** I'm not sure whether this will work on MacOS or not.

In order to use GCP docker image repositories, docker uses gcloud as an auth mechanism.  In
actuality, what is happening is this.

`docker push` -> `gcloud auth (inside docker)` -> `docker push (inside docker)`

`gcloud` attempts to invoke `docker push`, but it's unable to do so from within a docker container.
This is exactly what we're trying to accomplish by running `gcloud` in a container!  But it doesn't
help us here...  To accomplish this, we give `gcloud` access to the docker binary and socket
outside of the container.

Do not run `gcloud` this way in general.  Otherwise, you may as well just install `gcloud` locally.

```
alias gcloudconsoleimages='docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker gcloud bash'
```

## Mac OS Issues and Solutions with Pushing Images

Running the command stated above:
```
alias gcloudconsoleimages='docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker gcloud bash'
```
Will cause issues in Mac OS/OS X due to needing file sharing permissions set up via the Docker client.
EG:
```
$> docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker gcloud bash
docker: Error response from daemon: Mounts denied:
The path /usr/bin/docker
is not shared from OS X and is not known to Docker.
You can configure shared paths from Docker -> Preferences... -> File Sharing.
See https://docs.docker.com/docker-for-mac/osxfs/#namespaces for more info.
```
Unfortunately, Docker for Mac OS restricts /usr/bin/ and /usr/local/bin from being permitted in file sharing.

The way around this is to create a symbolic link to the Docker binary in your /usr/bin (or /usr/local/bin), in some handy directory docker can run from.

Example:
- `cd [project-folder]`
- `ln -s /usr/local/bin/docker ./symdocker`
- Then, change your mount-point so the command looks something like:
```
docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.kube:/root/.kube -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/symdocker:/usr/bin/docker gcloud bash
```

And you should be good to go.
