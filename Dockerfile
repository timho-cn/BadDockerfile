FROM python:3-slim-buster
# Specific Python version should be pinned

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl libpcre3 mime-support
# apt-get commands should be on same line (purists will say apt-get should be avoided altogether :shrug:)
# apt-get upgrade should be avoided because this will update all system packages to latest versions (invalidates immutable build)
# consider using --no-install-recommends flag

COPY . /src/app
# WORKDIR stanza could be specified
# Copying the entire directory in the middle of a Dockerfile will lead to frequent cache invalidation

RUN rm -rf /src/app/tests
# /src/app/tests directory is already baked into the image. This is only making the resulting image larger. Directory should be listed in .dockerignore if it's not meant to end up in resulting image.

RUN chmod +x /src/app/entrypoint.sh

RUN pip install -r /src/app/requirements.txt
# Consider --no-cache-dir

EXPOSE 80
# Seems like this would not change often, so can move to the top
# Not necessary to use port <1024

ENTRYPOINT ["/bin/sh", "/src/app/entrypoint.sh"]
# This container is run as root

# Potential optimizations/considerations:
# Multi-stage builds:
  # to eliminate build-time dependencies from prod image
    # why is it important to reduce the number of unneeded packages from prod image?
  # define image roles between development/prod
#
