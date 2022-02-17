# /Dockerfile
FROM ubuntu:18.04
# 18.04 Ubuntu 이미지
 
ADD entrypoint.sh /entrypoint.sh
# entrypoint.sh 파일 추가
 
RUN chmod +x /entrypoint.sh
# entrypoint.sh 파일에 권한
 
ENTRYPOINT ["/entrypoint.sh"]
# entrypoint.sh 수행
