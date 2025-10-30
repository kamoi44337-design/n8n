# 固定 n8n 版本，避免自动升级引起不兼容
FROM n8nio/n8n:1.79.2


# 可选：安装额外依赖（如需 Puppeteer/LibreOffice 等）
# RUN apk add --no-cache ...


# 使用我们自带的启动脚本（可注入变量、健康检查等）
COPY start.sh /docker-entrypoint-init.d/10-start.sh
RUN chmod +x /docker-entrypoint-init.d/10-start.sh
