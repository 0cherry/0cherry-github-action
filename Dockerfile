# /Dockerfile
FROM 0cherry/gh_env:latest
 
ADD entrypoint.sh /entrypoint.sh
# add entrypoint.sh

ADD parse_yml.sh /parse_yml.sh
 
RUN chmod +x /entrypoint.sh
# chmod entrypoint.sh

RUN chmod +x /parse_yml.sh
 
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
