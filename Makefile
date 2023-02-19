doclicense.tar.gz:

# Does not work. --prefix and --add-file with subpath are not compatible.
# git archive --verbose --worktree-attributes --prefix "$</" --add-file "$</$<.pdf" --output "$@" HEAD -- "$<"
%.tar.gz: %
	rm -f "$@"
	git archive --verbose --output "$<.tar" HEAD -- "$<"
	tar --append -f "$<.tar" "$</manifest.txt"
	tar --append -f "$<.tar" "$</$<.pdf"
	gzip "$<.tar"

.PHONY: docker-image
docker-image: Dockerfile
	docker build \
		--tag ypid/latex-packages \
		--file "$<" \
		--build-arg "USER_UID=$(shell id --user)" \
		--build-arg "USER_GID=$(shell id --group)" \
		.
	docker image tag ypid/latex-packages "ypid/latex-packages:$(shell sed --regexp-extended --quiet 's/^FROM.*://p;' Dockerfile)"

# https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#workdir
contain-base = \
	docker run \
		--rm \
		--name ypid-latex-packages \
		--volume "$(shell pwd):/home/user/latex-packages" \
		--workdir "/home/user/latex-packages"

contain-no-tty = \
	$(contain-base) \
		ypid/latex-packages

contain = \
	$(contain-base) \
		--tty \
		--interactive \
		ypid/latex-packages

.PHONY: run-tests-in-docker
run-tests-in-docker:
	$(contain-no-tty) make -C doclicense ci

.PHONY: shell
shell:
	$(contain)
