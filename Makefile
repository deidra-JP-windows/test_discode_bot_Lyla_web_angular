STAGE=dev
PREFIX=

.PHONY: clean
clean: ## distを初期化
	rm -rf dist

.PHONY: build
build: ## 指定環境のビルドを実行
	npm run build-${STAGE}

.PHONY: upload
upload: clean build
	aws s3 cp build s3://${STAGE}-${PREFIX}/ --recursive

.PHONY: upload_dev
upload_dev: ## [dev環境] s3にアップロード
	make upload STAGE=dev

.PHONY: upload_stg
upload_stg: ## [stg環境] s3にアップロード
	make upload STAGE=stg

.PHONY: upload_prod
upload_prod: ## [prod環境] s3にアップロード
	make upload STAGE=prod

.PHONY: install
install: ## npm install 必要に応じてオプションを追加
	npm install