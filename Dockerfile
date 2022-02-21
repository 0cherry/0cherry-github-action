# /Dockerfile
FROM 0cherry/gh_env:latest
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh
 
RUN chmod +x /entrypoint.sh
# chmod entrypoint.sh
 
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
