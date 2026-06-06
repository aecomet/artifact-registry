# Release Workflow

commitlint-base / reviewdog-base の Docker イメージをリリースする手順。

## 前提

- GitHub CLI (`gh`) がインストールされ、認証済みであること
- `CR_PAT` 環境変数に GitHub Personal Access Token（`write:packages` 権限）が設定済みであること
- Docker Buildx が有効であること
- リリースタグはセマンティックバージョニング（例: `26.3.0`）に従う

## リリース手順

### 0. ローカルから Docker イメージを publish

```bash
bash publish-image.sh commitlint <tag>
bash publish-image.sh reviewdog <tag>
```

例:

```bash
bash publish-image.sh commitlint 26.3.0
bash publish-image.sh reviewdog 26.3.0
```

### 1. 変更を commit & main に push

```bash
# 現在のブランチで残りの変更をコミット
git add -A
git commit -m "chore: release <tag>"

# main ブランチに切り替えてマージ
git checkout main
git merge <feature-branch>

# push
git push origin main
```

### 2. PR 作成（マージ後）

```bash
gh pr create \
  --title "chore: release <tag>" \
  --body "Docker イメージを \`<tag>\` に更新。" \
  --base main \
  --head <feature-branch>
```

### 3. GitHub Tag 打ち

```bash
git tag -a <tag> -m "Release <tag>"
git push origin <tag>
```

### 4. GitHub Release 作成

```bash
gh release create <tag> \
  --title "Release <tag>" \
  --notes "### 変更内容

- commitlint-base / reviewdog-base のベースイメージを Node.js <tag> に更新
- Dockerfile 最適化（--no-install-recommends, キャッシュ削除）
- CI ワークフローのアクションを更新"
```

### 5. 確認

- https://github.com/aecomet/artifact-registry/releases で Release が表示されること
- https://github.com/aecomet/artifact-registry/pkgs/container/commitlint-base で新しいタグのイメージが公開されていること
- https://github.com/aecomet/artifact-registry/pkgs/container/reviewdog-base で新しいタグのイメージが公開されていること

## 注意

- ローカル publish には Docker daemon の起動が必要
- `CR_PAT` は `write:packages` + `repo` スコープが必要
- マルチプラットフォームビルド（linux/amd64 + linux/arm64）のため初回ビルドは時間がかかる
- PR 作成前に `pnpm format:check` と `pnpm lint` のパスを確認
