# Convert .HEIC to .JPG using Docker

When air-dropping images between Apple devices images are transferred with a .HEIC format which most other platforms do not support. Using Docker makes it work for Windows and MacOS.

This Docker container has been published to a public registry  [george7522/heic2jpg](https://hub.docker.com/repository/docker/george7522/heic2jpg) so the build step below is not required.

![gif](2021-12-22_00.32.29.gif)

Prerequisites:
- Install docker https://docs.docker.com/get-docker/



## 1. Run the converter (without building)

### 1a) Windows

- Copy your HEIC files to a new directory eg. Downloads\ConvertMe

- Open a command prompt.

  - Windows Key, Search "CMD", left click CMD

- Run the converter

```bash
docker run -e DELETE_MODE=true -v C:\Users\$Username\Downloads\ConvertMe:/imgs george7522/heic2jpg:0.15
```

### 1b) MacOS

- Copy your HEIC files to a new directory eg. Downloads/ConvertMe

- Open a Terminal. eg. COMMAND+SPACE -> Terminal

- Run the converter

```bash
docker run -e DELETE_MODE=true -v ~/Downloads/ConvertMe:/imgs george7522/heic2jpg:0.15
```



docker run --rm -it -e DELETE_MODE=true -v $(pwd)/imgs/:/imgs/ george7522/heic2jpg:0.15

## 2. Run the converter with build 

### 2a) Windows

If you wish to customise this converter then you can clone this repo locally and edit the `app.sh`.

- Copy your HEIC files to a new directory eg. Downloads\ConvertMe

- Open a command prompt.

  - Windows Key, Search "CMD", left click CMD

- Run the converter

```powershell
docker run -e DELETE_MODE=true -v C:\Users\$Username\Downloads\ConvertMe:/imgs george7522/heic2jpg:0.15
```

### 2b) MacOS

- Build and run the converter

```bash
. build.sh 0.15
#Remove the `DELETE_MODE` flag if you wish to keep existing heic files.
docker run --rm -it -e DELETE_MODE=true -v ~/Downloads/ConvertMe:/imgs/ george7522/heic2jpg:0.15
```