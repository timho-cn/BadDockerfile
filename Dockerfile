FROM python:3-slim-buster

RUN apt-get install -y curl libpcre3 mime-support

COPY . /src/app

RUN rm -rf /src/app/tests

RUN chmod +x /src/app/entrypoint.sh

RUN pip install -r /src/app/requirements.txt

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/src/app/entrypoint.sh"]
