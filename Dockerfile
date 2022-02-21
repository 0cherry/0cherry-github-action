# /Dockerfile
FROM ubuntu:18.04
# 18.04 Ubuntu image

RUN echo $TARGET

RUN apt-get update
RUN apt-get install -y git
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh
 
RUN chmod +x /entrypoint.sh
# chmod entrypoint.sh
 
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

RUN /bin/sh /entrypoint.sh