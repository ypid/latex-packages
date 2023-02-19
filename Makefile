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
