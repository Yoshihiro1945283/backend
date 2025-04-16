# ベースとなるイメージを指定（軽量な Python 3.11 の slim バージョンを使用）
FROM python:3.11-slim

# コンテナ内の作業ディレクトリを /app に設定
WORKDIR /app

# アプリの依存関係ファイルをコンテナにコピー（requirements.txt を現在の作業ディレクトリにコピー）
COPY app/requirements.txt requirements.txt

# 依存関係をインストール（キャッシュを使わずに軽量化）
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーション本体をすべてコンテナにコピー（app ディレクトリの中身を /app にコピー）
COPY app/ .

# アプリケーションで使用するポートを開放（FastAPI や uvicorn のデフォルトに近い 8000 番を使用）
EXPOSE 8000

# コンテナ起動時に実行されるコマンドを指定（uvicorn で main.py 内の app を起動）
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--log-level", "info"]
