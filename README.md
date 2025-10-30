# n8n on Railway (GitHub-driven)


一键用 Railway 部署 n8n，代码托管在 GitHub。支持：
- Dockerfile 构建（稳定可控）
- PostgreSQL（推荐）或 Volume + SQLite（简易）
- 自定义域名 + HTTPS
- 基础密码与加密密钥（保证安全）


## 快速开始


1. **Fork 本仓库** 到你的 GitHub 账号。
2. 打开 **Railway** → New Project → **Deploy from GitHub Repo** → 选择本仓库。
3. 在 Railway → **Variables**：
- 设置 `N8N_BASIC_AUTH_USER`, `N8N_BASIC_AUTH_PASSWORD`, `N8N_ENCRYPTION_KEY`（必须）。
- 设置 `N8N_PROTOCOL=https`，`N8N_HOST=<你的域名或 Railway 域名>`。
4. 选择持久化方式：
- **A）PostgreSQL（推荐）**：在 Railway 添加 **PostgreSQL 插件**，把其提供的 `HOST/PORT/USER/PASSWORD` 等写入 `DB_POSTGRESDB_*` 环境变量，并设置 `DB_TYPE=postgresdb`。
- **B）Volume + SQLite**：在 Railway → Project → Add **Volume**，挂载到服务（Mount Path 建议 `/data`），并设置 `DB_TYPE=sqlite`、`N8N_USER_FOLDER=/data`。
5. 等待构建成功后，访问 Railway 提供的域名（或绑定自定义域名）。


## 自定义域名
Railway → 域名（Domains）中添加你的域名，完成 DNS 验证后即可自动签颁 HTTPS。记得把：
- `N8N_HOST=你的域名`
- `N8N_PROTOCOL=https`


## 版本控制
- 默认使用 `n8nio/n8n:1.79.2`。如需升级，修改 `Dockerfile` 版本并推送 GitHub；Railway 会自动重新构建。


## 安全建议
- 必须设置强密码与 `N8N_ENCRYPTION_KEY`（32 字符随机字符串）。
- 关闭匿名遥测：`N8N_DIAGNOSTICS_ENABLED=false`。
- 如果公开暴露在公网，建议仅允许特定 IP（在上游反代或 WAF 实现）。


## 备份
- **Postgres**：使用 Railway 的备份功能或定时导出 SQL。
- **SQLite+Volume**：定期从 Volume 路径（如 `/data`）下载 `database.sqlite`、`config`、`credentials` 等文件。


## 常见问题
- **构建失败**：确认 `Dockerfile` 语法、Railway 使用 Docker 构建（见 `railway.json`）。
- **端口不通**：Railway 会把端口写入 `$PORT`，我们在 `start.sh` 已兼容。
- **Webhook 回调不通**：确认 `N8N_HOST / N8N_PROTOCOL` 设置正确，且域名已可公网访问。
- **升级后凭据丢失**：确保使用 **Postgres** 或 **Volume**，同时 `N8N_ENCRYPTION_KEY` 不要变。
