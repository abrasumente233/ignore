CC?=gcc

.PHONY: all
all: ignore

ignore: ignore.c ingore_table.h
	$(CC) $< -o $@ -O3 -fno-lto

ingore_table.h: ignore_files.h

ignore_files.h:
	git submodule init
	git submodule update
	bash -e make_include.sh

.PHONY: clean
clean:
	rm -rf ingore_table.h ignore_files.h ignore