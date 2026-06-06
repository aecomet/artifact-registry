# Agent Instructions for artifact-registry

このリポジトリは Docker イメージ (`commitlint-base`, `reviewdog-base`) を GitHub Container Registry に公開するプロジェクトです。

## 基本ルール

- 回答は日本語
- 設定変更前は既存の全ファイルを確認してから行う
- CI のワークフローは `.github/workflows/` 以下を参照

## Git Hooks (Lefthook)

ローカル開発時に以下のフックが `lefthook.yml` で設定されています:

| Hook         | 内容                                          |
| ------------ | --------------------------------------------- |
| `pre-commit` | Prettier フォーマット + EditorConfig チェック |
| `commit-msg` | commitlint によるコミットメッセージ検証       |
| `pre-push`   | opencode による差分レビュー                   |

セットアップ:

```bash
brew install lefthook
lefthook install
```

## Skills

各タスクごとの詳細手順は `.agent/skills/` 以下を参照:

- [Update Dependencies](.agent/skills/update-dependencies/SKILL.md) — 依存関係の一括アップデート手順
- [Release Workflow](.agent/skills/release-workflow/SKILL.md) — Docker イメージのリリース手順（publish / PR / tag / release）
