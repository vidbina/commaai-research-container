## Setup

Ensure there is a `settings.mk` file that specifies the owner, project, version
and work directory of the container. The work directory should be th path on
the host to the comma.ai research repository.

```Makefile
CONTAINER_OWNER=vidbina
CONTAINER_PROJECT=comma.ai-research
CONTAINER_VERSION=$(shell cat VERSION)
CONTAINER_WORKDIR=/home/vidbina/src/comma.ai-research
```
