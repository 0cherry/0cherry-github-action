# /Dockerfile
FROM ubuntu:18.04
# 18.04 Ubuntu image
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh
 
RUN chmod +x /entrypoint.sh
# chmoe entrypoint.sh
 
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
# run entrypoint.sh
# ENTRYPOINT ["echo", "hello action"]

RUN /bin/sh /entrypoint.sh

COPY /report.txt report.txt