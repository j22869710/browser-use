# 使用 Python + Node 的基底映像
FROM python:3.11-slim

# 安裝系統必要套件
RUN apt-get update && apt-get install -y curl gnupg

# 安裝 Node.js 官方版（比如 node 20）
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# 建立工作目錄
WORKDIR /app

# 複製整個專案
COPY . .

# 安裝 Python 依賴
RUN pip install -r requirements.txt

# 安裝 Node.js 依賴並 build 前端頁面
WORKDIR /app/browser_use/server/pages
RUN npm install && npm run build

# 回到主目錄
WORKDIR /app

# 開放 Port
EXPOSE 3000

# 啟動 FastAPI 伺服器
CMD ["uvicorn", "browser_use.server.main:app", "--host", "0.0.0.0", "--port", "3000"]
