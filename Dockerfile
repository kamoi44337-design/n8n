FROM n8nio/n8n:1.79.2
# Optional: install extra packages if your workflows require them
# RUN apk add --no-cache ...

# 复制启动脚本并在复制时直接赋予可执行权限（兼容 Railway 沙箱）
COPY --chmod=755 start.sh /docker-entrypoint-init.d/10-start.sh
