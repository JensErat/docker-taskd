# Taskwarrior taskd for Docker

(c) 2015 Jens Erat  
Redistribution and modifications are welcome, see the LICENSE file for details.

[Taskwarrior](http://www.taskwarrior.org) is an open-source cross platform command-line task management tool. It allows you to capture, annotate, manipulate and present your tasks, then sync them among devices.

This Dockerfile packages taskd, Taskwarrior's sync server, built from source.

## Setup

The image stores configuration and data in `/var/taskd`, which you should persist somewhere. Example configuration is copied during each startup of the container into the `/var/taskd/orig` directory, which you can adjust for your own use. For creating the initial directory hierarchy and example configuration, simply run the container with the `/var/taskd` volume already exposed or linked, for example using

    docker run -v /srv/taskd:/var/taskd jenserat/taskd

Copy both the `config` file and the `orgs` directory (which contains the data) out of `orig`. Make sure to set `server=0.0.0.0:53589`, so the port can actually be exposed by docker, `root=/var/taskd` (which is still set to the `orig` subfolder) and `log=/var/log/taskd.log`, which is redirected to stdout (so `docker logs` can collect it).

Make sure all files are owned by the container's taskd user (uid 53589), for example by running

    chown -R 53589 /srv/taskd

For setting up taskd, refer to official documentation.

## Running a Container

Run the image in a container, exposing taskd's port and making `/var/taskd` permanent. An example run command might be

    docker run -d \
      --name='taskd' \
      --publish='53589:53589' \
      --volume='/srv/taskd:/var/taskd' \
      jenserat/taskd

## Upgrading and Maintenance

Refer to the official documentation regarding any actions needed for upgrading taskd.
