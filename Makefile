RUN := docker compose run --rm latex
DATE := $(shell date +%Y%m%d)
ARCHIVE := midterm-report_$(DATE).zip

.PHONY: pdf watch clean archive shell

## PDFを1回ビルドする
pdf:
	$(RUN) latexmk main.tex

## ファイル変更を監視して自動再ビルド（Ctrl+Cで終了）
watch:
	$(RUN) latexmk -pvc -view=none main.tex

## 生成物（aux, dvi, pdf など）を削除する
clean:
	$(RUN) latexmk -C main.tex

## 提出用zipを生成する（PDF込み）
archive: pdf
	rm -f $(ARCHIVE)
	zip $(ARCHIVE) main.pdf main.tex chapter*.tex appendix*.tex funpro-2026.sty latexmkrc
	zip -r $(ARCHIVE) figures -x '*.DS_Store' -x '*.gitkeep'
	@echo "==> $(ARCHIVE) を作成しました"

## コンテナ内のシェルに入る（デバッグ用）
shell:
	$(RUN) bash
