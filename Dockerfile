# 使用 Node.js 20 環境
FROM node:20-bullseye

# 安裝 Python 與 Playwright 所需套件
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    npm install -g npm@latest

# 建立工作目錄
WORKDIR /app

# 複製專案檔案
COPY . .

# 安裝依賴（包含 Playwright browser binaries）
RUN npm install && npx playwright install --with-deps

# 開放 port（可自訂）
EXPOSE 3000

# 啟動 browser-use（可改為 dev）
CMD ["npm", "run", "start"]
