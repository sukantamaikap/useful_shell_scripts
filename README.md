# useful_shell_scripts

A collection of useful shell scripts, along with dockerizd testing environment.  

## Pre-requisites

Install docker. This is tested on Docker CE 18.06.0

## About the testing environment

A docker compose file is present with 1 master and 2 slave centos 7 hosts. The code base is mounted into the master host at :

```bash
/sandbox/src
```

To bring up the docker environment, clone this repo and go to the root of the project and type :

```bash
docker-compose up
```

Now you can connect to the docker service named master by typing  

```bash
docker-compose exec master
```

and run the script from 

```bash
/sandbox.src
```
