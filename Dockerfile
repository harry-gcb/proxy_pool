FROM python:3.6-alpine

MAINTAINER harry.gao

WORKDIR /app

COPY . .
# COPY ./requirements.txt .

# 1. apk repository
# 2. timezone
# 3. runtime environment
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \ 
    apk add -U tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata && \
    apk add musl-dev gcc libxml2-dev libxslt-dev && \
    pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ && \
    apk del gcc musl-dev


EXPOSE 5010

ENTRYPOINT [ "sh", "start.sh" ]
