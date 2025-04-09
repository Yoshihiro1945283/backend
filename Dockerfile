# Python 3.11 の軽量バージョン（slim）をベースイメージとして使用
FROM python:3.11-slim

# 作業ディレクトリを /app に設定（以降のコマンドはこのディレクトリ内で実行される）
WORKDIR /app

# アプリの依存関係ファイル（requirements.txt）をコンテナの作業ディレクトリにコピー
COPY app/requirements.txt .

# Python パッケージの依存関係をインストール（--no-cache-dir でイメージを軽量に保つ）
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのコード全体をコンテナの作業ディレクトリにコピー
COPY app/ .

# コンテナ外部からアクセスできるように、ポート8000番を開放
EXPOSE 8000

# コンテナ起動時に実行するコマンドを指定
# uvicorn を使って main.py 内の app を起動（--reload によりホットリロードを有効化、開発時に便利）
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
