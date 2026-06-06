---
applyTo: '**'
---

## 回答

- 日本語で回答してください。

## 依存関係のアップデート手順

以下の順序で実行すること:

1. **Node.js バージョンの更新**

- `.node-version` のバージョンを最新 LTS に更新
- `commitlint/Dockerfile` と `reviewdog/Dockerfile` の `FROM node:` タグを更新
- `.github/workflows/lint-runner.yml` の image タグを更新

2. **GitHub Actions の更新**

- `.github/workflows/*.yml` 内の各アクションの最新版を確認:
  - `actions/checkout`
  - `docker/login-action`
  - `docker/setup-buildx-action`
  - `docker/metadata-action`
  - `docker/build-push-action`
- メジャーバージョンアップがある場合はリリースノートを確認の上、置き換えを提案

3. **Docker イメージの最適化**

- `--no-install-recommends` で不要パッケージを削減
- `apt-get clean && rm -rf /var/lib/apt/lists/*` でキャッシュ削除
- `apt` ではなく `apt-get` を使用（安定したインターフェース）
- レイヤー数を最小化

4. **設定ファイルの整備**

- 無効な JSON / YAML がないか確認
- 古い設定や不要なファイルを削除
- IDE 設定 (.vscode/) をプロジェクト標準に合わせる
