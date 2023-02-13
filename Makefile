doclicense.tar.gz:

# Does not work. --prefix and --add-file with subpath are not compatible.
# git archive --verbose --worktree-attributes --prefix "$</" --add-file "$</$<.pdf" --output "$@" HEAD -- "$<"
%.tar.gz: %
	rm -f "$@"
	git archive --verbose --output "$<.tar" HEAD -- "$<"
	tar --append -f "$<.tar" "$</manifest.txt"
	tar --append -f "$<.tar" "$</$<.pdf"
	gzip "$<.tar"
