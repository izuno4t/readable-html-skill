# Build, package, and install readable-html skill outputs.

AGENT ?= all

.PHONY: build package install uninstall status clean lint

build:
	scripts/build $(AGENT)

package: build
	scripts/package $(AGENT)

install: build
	scripts/link link $(AGENT)

uninstall:
	scripts/link unlink $(AGENT)

status:
	scripts/status

clean:
	rm -rf agents dist

lint:
	markdownlint-cli2 README.md
	cspell --no-progress "**/*.md"
	bash -n scripts/build scripts/link scripts/package scripts/status
