# Update Dependencies

artifact-registry プロジェクトの依存関係を体系的にアップデートする手順。

## 更新手順

### 1. Node.js バージョンの更新

最新の Node.js (Current) バージョンを確認し、以下を更新する:

| ファイル                            | 更新内容                                           |
| ----------------------------------- | -------------------------------------------------- |
| `.node-version`                     | バージョン文字列 (例: `26.3.0`)                    |
| `commitlint/Dockerfile`             | `FROM node:<version>-slim`                         |
| `reviewdog/Dockerfile`              | `FROM node:<version>-slim`                         |
| `.github/workflows/lint-runner.yml` | `image: ghcr.io/aecomet/commitlint-base:<version>` |
| `README.md`                         | サンプルコマンドのタグ                             |
| `.github/workflows/build.yml`       | `description` の例                                 |

### 2. Dockerfile 最適化

- `apt` → `apt-get`（stable interface）
- `--no-install-recommends` で不要パッケージ排除
- インストール後 `apt-get clean && rm -rf /var/lib/apt/lists/*` でキャッシュ削除
- `COPY` は `RUN` の後に移動（レイヤーキャッシュ効率化）

### 3. GitHub Actions 更新

`.github/workflows/*.yml` 内を最新メジャーバージョンに:

- `actions/checkout` → 最新 `@v<major>`
- `docker/login-action` → 最新 `@v<major>`
- `docker/setup-buildx-action` → 最新 `@v<major>`
- `docker/metadata-action` → 最新 `@v<major>`
- `docker/build-push-action` → 最新 `@v<major>`

メジャーバージョンアップ時はリリースノートで破壊的変更を確認。

### 4. 設定ファイル整備

- `.vscode/extensions.json` が valid JSON か確認
- `.editorconfig`, `prettier.config.js` が最新ツールと互換性あるか確認
- `.github/dependabot.yml` の設定確認

### 5. 不要ファイル削除

- `.DS_Store` などの OS 生成ファイル
- 使われていない設定ファイル

## Lefthook のセットアップ

```bash
brew install lefthook
lefthook install
```

フック設定は `lefthook.yml`、スクリプトは `.lefthook/` 以下を参照。

## 確認

```bash
# Dockerfile lint
docker run --rm -i hadolint/hadolint < commitlint/Dockerfile
docker run --rm -i hadolint/hadolint < reviewdog/Dockerfile
# YAML syntax check
yamllint .github/workflows/*.yml
# JSON syntax check
python3 -m json.tool .vscode/extensions.json > /dev/null
# Lefthook check
lefthook check
```

## 注意

- Node.js のメジャーバージョンアップ時は `@commitlint/*` の互換性を確認
- Docker イメージは `linux/amd64` + `linux/arm64` のマルチプラットフォームビルド
- pnpm のメジャーバージョンアップ時は破壊的変更をリリースノートで確認
