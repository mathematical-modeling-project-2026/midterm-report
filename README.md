# 数理モデリングプロジェクト 中間報告書

funpro-2026 テンプレート（upLaTeX → dvipdfmx）の報告書リポジトリです。
**ローカルにTeXをインストールする必要はありません。** ビルドはすべて Docker コンテナ
（`texlive/texlive:TL2025-historic`）の中で行うので、全員のマシンで同じPDFが出ます。

## 最初に1回だけやること（全員共通）

1. [Docker Desktop](https://www.docker.com/products/docker-desktop/) をインストールして起動する
2. このリポジトリを clone する
3. 動作確認：

   ```sh
   make pdf
   ```

   初回はTeX Liveイメージ（数GB）のダウンロードが走るので**10分以上かかることがあります**。
   2回目以降は数十秒です。`main.pdf` ができれば成功。

## 執筆スタイル別の使い方

### ① VS Code 派

1. 拡張機能「Dev Containers」を入れる
2. このフォルダを開き、右下の通知から **「Reopen in Container」** を選ぶ
3. あとは `.tex` を編集して保存するだけで自動ビルドされ、PDFプレビューが更新される
   （LaTeX Workshop が自動で入ります。PDF上で ⌘クリックすると該当ソースに飛べます）

### ② neovim など好きなエディタ派

ターミナルで監視ビルドを立ち上げておき、いつものエディタで編集する：

```sh
make watch   # 保存するたびに自動再ビルド。Ctrl+C で終了
```

### ③ ビルドしない人（内容確認・校正だけしたい人）

GitHub の **Actions タブ → 最新の実行 → Artifacts → `midterm-report-pdf`**
から常に最新のPDFをダウンロードできます。環境構築は不要です。

## コマンド一覧

| コマンド | 内容 |
|---|---|
| `make pdf` | PDFを1回ビルド |
| `make watch` | 変更を監視して自動再ビルド |
| `make clean` | 生成物を削除 |
| `make archive` | 提出用zip（PDF込み）を生成 |
| `make shell` | コンテナ内のシェルに入る（デバッグ用） |

## 執筆ルール

- **自分の担当章（`chapterN.tex`）だけを編集する。** 章ファイルは main への直接 push でOK
- **共有ファイル（`main.tex` / `funpro-2026.sty` / `Makefile` など）を触るときは、事前にグループに声をかける**
- `funpro-2026.sty` と `latexmkrc` は提出用テンプレートなので**変更禁止**
- PDFや中間生成物（aux等）はコミットしない（`.gitignore` 済み。PDFはActionsのArtifactから取得）
- 図は `figures/` に置く。ファイル名は章番号プレフィックス推奨（例：`figures/ch3_bus_model.png`）
- push すると GitHub Actions が自動でビルドする。**赤くなったら壊した人が直す**（直せなければグループに相談）

## トラブルシューティング

- `Cannot connect to the Docker daemon` → Docker Desktop が起動しているか確認
- ビルドが通らない → `make clean && make pdf` を試す。それでもダメならエラーログ（`main.log`）の最後の方を見る
- 日本語が化ける・フォントエラー → イメージのタグが `TL2025-historic` のままか確認（勝手に変えない）
