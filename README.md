# BadDockerfile

Dockerfile with common anti-patterns/mistakes (for interview panel)

## Dockerfile Comments

*FROM python:3-slim-buster*
- Specific Python version should be pinned (3/3)

*RUN apt-get install -y curl libpcre3 mime-support*
- Consider using --no-install-recommends flag (1/3)
- There is no apt-get update, so package metadata most likely will not be available (2/3)

*COPY . /src/app*
- WORKDIR stanza could be specified (2/3)
- Copying the entire directory in the middle of a Dockerfile will lead to frequent cache invalidation (3/3)

*RUN rm -rf /src/app/tests*
- /src/app/tests directory is already baked into the image. This is only making the resulting image larger. Directory should be listed in .dockerignore if it's not meant to end up in resulting image. (3/3)

*RUN chmod +x /src/app/entrypoint.sh*

*RUN pip install -r /src/app/requirements.txt*
- Consider --no-cache-dir (1/3)

*EXPOSE 80*
- Seems like this would not change often, so can move to the top of the Dockerfile (1/3)

*ENTRYPOINT ["/bin/sh", "/src/app/entrypoint.sh"]*
- This container runs as root (2/3)

## entrypoint.sh comments
*python signals.py*
- This shell script will be PID 1 (will not properly relay signals)

## Potential optimizations/considerations:
- Multi-stage builds:
  - to eliminate build-time dependencies from prod image
    - why is it important to reduce the number of unneeded packages from prod image?
  - define image roles between development/prod

- CI/CD questions
- Build once, deploy many strategy
