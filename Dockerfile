FROM python:3.7-alpine

RUN apk add --no-cache --virtual build-deps \
        git \
    && git clone --depth 1 https://github.com/binlab/django-markdown-editor.git /build \
    && cd /build \
    && python setup.py install \
    && python martor_demo/manage.py makemigrations \
    && python martor_demo/manage.py migrate \
    && mv martor_demo/ /app \
    && cd / \
    && rm -rf /build \
    && apk del build-deps
    
WORKDIR /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver"]
