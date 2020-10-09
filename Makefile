#  powered by metaL: https://github.com/ponyatov/metaL/wiki/metaL-manifest
# \ <section:top>
# \ <section:vars>
# \ <section:module>
MODULE   = $(notdir $(CURDIR))
# / <section:module>
OS      ?= $(shell uname -s)
# / <section:vars>
# \ <section:version>
NOW      = $(shell date +%d%m%y)
REL      = $(shell git rev-parse --short=4 HEAD)
# / <section:version>
# \ <section:dirs>
CWD      = $(CURDIR)
BIN      = $(CWD)/bin
TMP      = $(CWD)/tmp
SRC      = $(CWD)/src
# / <section:dirs>
# \ <section:tools>
WGET     = wget -c --no-check-certificate
CORES    = $(shell grep proc /proc/cpuinfo|wc -l)
XPATH    = PATH=$(BIN):$(PATH)
XMAKE    = $(XPATH) $(MAKE) -j$(CORES)
ERL      = erl
ERLC     = erlc
IEX      = iex
MIX      = mix
ELIXIR   = elixir
ELIXIRC  = elixirc
# / <section:tools>
# / <section:top>
# \ <section:mid>
PHONY: all
all: \
	# \ <section:all>
	$(MIX) format
	$(MIX) compile
	# / <section:all>
# \ <section:repl>
.PHONY: repl
repl:
	$(MIX) format
	$(IEX) -S $(MIX)
	$(MAKE) $@
# / <section:repl>
# \ <section:doc>
.PHONY: doc
doc: doc/programming-erlang-russian.pdf doc/learnyousomeerlang_ru.pdf doc/programming-erlang-2nd-edition.pdf

doc/programming-erlang-russian.pdf:
	$(WGET) -O $@ https://github.com/dyp2000/Russian-Armstrong-Erlang/raw/master/pdf/fullbook.pdf
doc/learnyousomeerlang_ru.pdf:
	$(WGET) -O $@ https://github.com/mpyrozhok/learnyousomeerlang_ru/raw/master/pdf/learnyousomeerlang_ru.pdf
doc/programming-erlang-2nd-edition.pdf:
	$(WGET) -O $@ https://gangrel.files.wordpress.com/2015/08/programming-erlang-2nd-edition.pdf
# / <section:doc>
# \ <section:rules>
%.core: src/%.erl
	$(ERLC) +to_core $<
# / <section:rules>
# / <section:mid>
# \ <section:bot>
# \ <section:install>
.PHONY: install
install:
	$(MAKE) $(OS)_install
	$(MAKE) doc
	$(MIX) deps.get && $(MIX) compile
# / <section:install>
# \ <section:update>
.PHONY: update
update:
	$(MAKE) $(OS)_update
	$(MIX) deps.get && $(MIX) compile
# / <section:update>
# \ <section:linux/install>
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	-sudo apt update
	-sudo apt install -u `cat apt.txt`
# / <section:linux/install>
# \ <section:merge>
MERGE  = Makefile apt.txt .gitignore .vscode
MERGE += doc src tmp README.md
MERGE += lib .formatter.exs mix.exs
# / <section:merge>
.PHONY: master shadow release zip

master:
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)

shadow:
	git checkout $@
	git pull -v

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow

zip:
	git archive --format zip \
	--output ~/tmp/$(MODULE)_src_$(NOW)_$(REL).zip \
	HEAD
# / <section:bot>
