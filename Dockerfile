# /Dockerfile
FROM ubuntu:18.04
# 18.04 Ubuntu �̹���
 
ADD entrypoint.sh /entrypoint.sh
# entrypoint.sh ���� �߰�
 
RUN chmod +x /entrypoint.sh
# entrypoint.sh ���Ͽ� ����
 
ENTRYPOINT ["/entrypoint.sh"]
# entrypoint.sh ����
