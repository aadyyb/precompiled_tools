.PHONY: build-cobra build-ginkgo build-github-release-resource

.DEFAULT_GOAL := help
SHELL := /usr/bin/env bash
COBRA_SRC = github.com/spf13/cobra/cobra
GINKGO_SRC = github.com/onsi/ginkgo/ginkgo
GITHUB_RELEASE_RESOURCE_CHECK_SRC = github.com/concourse/github-release-resource/cmd/check
GITHUB_RELEASE_RESOURCE_IN_SRC = github.com/concourse/github-release-resource/cmd/in
GITHUB_RELEASE_RESOURCE_OUT_SRC = github.com/concourse/github-release-resource/cmd/out
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
build-github-release-resource: ### Build github-release-resource
	rm -rf build
	rm -rf release
	mkdir -p build/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/check $(GITHUB_RELEASE_RESOURCE_CHECK_SRC)
	mkdir -p build/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o build/darwin/amd64/check $(GITHUB_RELEASE_RESOURCE_CHECK_SRC)
	mkdir -p release/
	tar -cvzf release/check-linux-amd64.tar.gz -C build/linux/amd64 check
	tar -cvzf release/check-darwin-amd64.tar.gz -C build/darwin/amd64 check
	$(SHA512SUM) release/check-linux-amd64.tar.gz >release/check-linux-amd64.tar.gz.sha256sum
	$(SHA512SUM) release/check-darwin-amd64.tar.gz >release/check-darwin-amd64.tar.gz.sha256sum
	mkdir -p build/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/in $(GITHUB_RELEASE_RESOURCE_IN_SRC)
	mkdir -p build/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o build/darwin/amd64/in $(GITHUB_RELEASE_RESOURCE_IN_SRC)
	tar -cvzf release/in-linux-amd64.tar.gz -C build/linux/amd64 in
	tar -cvzf release/in-darwin-amd64.tar.gz -C build/darwin/amd64 in
	$(SHA512SUM) release/in-linux-amd64.tar.gz >release/in-linux-amd64.tar.gz.sha256sum
	$(SHA512SUM) release/in-darwin-amd64.tar.gz >release/in-darwin-amd64.tar.gz.sha256sum
	mkdir -p build/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/out $(GITHUB_RELEASE_RESOURCE_OUT_SRC)
	mkdir -p build/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o build/darwin/amd64/out $(GITHUB_RELEASE_RESOURCE_OUT_SRC)
	tar -cvzf release/out-linux-amd64.tar.gz -C build/linux/amd64 out
	tar -cvzf release/out-darwin-amd64.tar.gz -C build/darwin/amd64 out
	$(SHA512SUM) release/out-linux-amd64.tar.gz >release/out-linux-amd64.tar.gz.sha256sum
	$(SHA512SUM) release/out-darwin-amd64.tar.gz >release/out-darwin-amd64.tar.gz.sha256sum