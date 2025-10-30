#!/usr/bin/env bash
set -e


# Railway 默认将端口写入 $PORT。n8n 默认 5678，这里做兼容。
export N8N_PORT="${PORT:-5678}"


# 如果设置了 N8N_HOST/N8N_PROTOCOL，自动拼 WEBHOOK_URL（对外 URL）。
if [ -n "$N8N_HOST" ] && [ -n "$N8N_PROTOCOL" ]; then
export WEBHOOK_URL="$N8N_PROTOCOL://$N8N_HOST/"
fi


# 打印关键信息（排错用）
echo "[n8n] starting on port $N8N_PORT, WEBHOOK_URL=${WEBHOOK_URL:-unset}"


# 交给原镜像入口启动
exec /docker-entrypoint.sh n8n
