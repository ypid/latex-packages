doclicense.tar:

# Does not work. --prefix and --add-file with subpath are not compatible.
# git archive --verbose --worktree-attributes --prefix "$</" --add-file "$</$<.pdf" --output "$@" HEAD -- "$<"
%.tar: %
	git archive --verbose --output "$@" HEAD -- "$<"
	tar --append -f "$@" "$</$<.pdf"
