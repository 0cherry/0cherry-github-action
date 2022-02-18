# /Dockerfile
FROM ubuntu:18.04
# 18.04 Ubuntu image
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh
 
RUN chmod +x /entrypoint.sh
# chmoe entrypoint.sh
 
ENTRYPOINT ["ls", "-l", "/entrypoint.sh"]
# run entrypoint.sh
# ENTRYPOINT ["echo", "hello action"]
