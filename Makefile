.PHONY: build-cobra build-ginkgo

.DEFAULT_GOAL := help
SHELL := /usr/bin/env bash
COBRA_SRC = github.com/spf13/cobra/cobra
GINKGO_SRC = github.com/onsi/ginkgo/ginkgo
SHA512SUM = $(shell command -v sha256sum || echo "shasum -a 256")

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-cobra: ### Build cobra
	rm -rf build
	rm -rf release
	mkdir -p build/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/cobra $(COBRA_SRC)
	mkdir -p build/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o build/darwin/amd64/cobra $(COBRA_SRC)
	mkdir -p release/
	tar -cvzf release/cobra-linux-amd64.tar.gz -C build/linux/amd64 cobra
	tar -cvzf release/cobra-darwin-amd64.tar.gz -C build/darwin/amd64 cobra
	$(SHA512SUM) release/cobra-linux-amd64.tar.gz >release/cobra-linux-amd64.tar.gz.sha256sum
	$(SHA512SUM) release/cobra-darwin-amd64.tar.gz >release/cobra-darwin-amd64.tar.gz.sha256sum

build-ginkgo: ### Build ginkgo
	rm -rf build
	rm -rf release
	mkdir -p build/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/ginkgo $(GINKGO_SRC)
	mkdir -p build/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o build/darwin/amd64/ginkgo $(GINKGO_SRC)
	mkdir -p release/
	tar -cvzf release/ginkgo-linux-amd64.tar.gz -C build/linux/amd64 ginkgo
	tar -cvzf release/ginkgo-darwin-amd64.tar.gz -C build/darwin/amd64 ginkgo
	$(SHA512SUM) release/ginkgo-linux-amd64.tar.gz >release/ginkgo-linux-amd64.tar.gz.sha256sum
	$(SHA512SUM) release/ginkgo-darwin-amd64.tar.gz >release/ginkgo-darwin-amd64.tar.gz.sha256sum