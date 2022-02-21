# /Dockerfile
FROM 0cherry/gh_env:latest

RUN git config --global user.email ""
RUN git config --global user.name ""
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh
 
RUN chmod +x /entrypoint.sh
# chmod entrypoint.sh
 
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
