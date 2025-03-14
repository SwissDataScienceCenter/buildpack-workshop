.PHONY: default
default: help

.PHONY:configure
configure:
	pack config default-builder paketobuildpacks/builder-jammy-buildpackless-full:latest
	pack config trusted-builders add paketobuildpacks/builder-jammy-buildpackless-full:latest

.PHONY: build
build:
	pack build dash-sample-app --path ./dash-sample-app \
		--buildpack gcr.io/paketo-buildpacks/python \
		--buildpack gcr.io/paketo-buildpacks/pip \
		--buildpack ./py-dash-buildpack \
		--env BP_CPYTHON_VERSION="3.12.*"

# .PHONY:build
# build: ## Build the image with the custom buildpack
# 	pack build test-node-js-app --clear-cache --path ./node-js-sample-app --buildpack ./node-js-buildpack

# .PHONY:build_with_ui
# build_with_ui: ## Build the image with the custom buildpack and the vscode buildpack
# 	pack build test-node-js-app-with-ui --clear-cache --path ./node-js-sample-app --buildpack ./node-js-buildpack --buildpack ghcr.io/swissdatasciencecenter/vscodium-buildpack/vscodium:0.1.2

# .PHONY:run
# run: build ## Run the image with your custom buildpack
# 	docker run -ti --rm -p 8080:8080 test-node-js-app

# .PHONY:run_with_ui
# run_with_ui: build_with_ui  ## Run the image with the custom buildpack and the vscode buildpack
# 	docker run -ti --rm -p 8000:8000 -e RENKU_SESSION_PORT=8000 test-node-js-app-with-ui

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

