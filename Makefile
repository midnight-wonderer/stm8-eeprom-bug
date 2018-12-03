SHELL=/usr/bin/env bash
SDCC=sdcc
SDCCLIB=sdcclib
SRCDIR=./src
BINDIR=./bin
INCLUDES=\
./vendor/stm8s/inc\
./vendor/button_debounce/inc
CFLAGS= --std-c11 --nolospre $(addprefix -I,$(INCLUDES))
LDFLAGS=--out-fmt-ihx
ENTRY_SOURCE_FILE=$(shell find $(SRCDIR) -maxdepth 1 -name "main.c")
APP_SOURCE_FILES=$(filter-out $(ENTRY_SOURCE_FILE), $(shell find $(SRCDIR) -name "*.c"))
LIB_SOURCE_FILES=$(shell find $(INCLUDES) -name "*.c")
ENTRY_OBJECT=$(subst /./,/,$(addprefix $(BINDIR)/,$(ENTRY_SOURCE_FILE:.c=.rel)))
APP_OBJECTS=$(subst /./,/,$(addprefix $(BINDIR)/,$(APP_SOURCE_FILES:.c=.rel)))
LIB_OBJECTS=$(subst /./,/,$(addprefix $(BINDIR)/,$(LIB_SOURCE_FILES:.c=.rel)))

.PHONY: all build clean

all: build

build: $(BINDIR)/program.hex

clean:
	rm -rf $(BINDIR)/

$(BINDIR)/program.hex: $(ENTRY_OBJECT) $(BINDIR)/vendor.lib $(BINDIR)/app.lib
	$(SDCC) -mstm8 -lstm8 -o $@ $(LDFLAGS) $^

$(BINDIR)/%.rel: %.c
	mkdir -p $(dir $@) &&\
	$(SDCC) -mstm8 -o $@ -c $(CFLAGS) $^

$(BINDIR)/vendor.lib: $(LIB_OBJECTS)
	[[ ! -z "$^" ]] &&\
	$(SDCCLIB) $@ $^ ||\
	touch $@

$(BINDIR)/app.lib: $(APP_OBJECTS)
	[[ ! -z "$^" ]] &&\
	$(SDCCLIB) $@ $^ ||\
	touch $@

%.c: %.h
