#


src_dir := src
data_src_dir := $(src_dir)/data
rst_dir := $(src_dir)/rst


build_dir := build
data_dir := $(build_dir)/data


rst_files := $(wildcard $(rst_dir)/*.rst)
html_files := $(patsubst $(rst_dir)/%.rst,$(build_dir)/%.html,$(rst_files))


data_src_files := $(wildcard $(data_src_dir)/*)
data_files := $(patsubst $(data_src_dir)/%,$(data_dir)/%,$(data_src_files))


all_files := $(data_files) $(html_files)


rst2sh5_options := --strict --strip-comments
rst2sh5_options += --initial-header-level=2
rst2sh5_options += --link-stylesheet --stylesheet=''


vpath %.rst $(rst_dir)
vpath % $(data_src_dir)


.DEFAULT_GOAL := all


.PHONY: all
all: $(all_files)


.PHONY: nothing
nothing:
	true


$(data_dir)/%: % | $(data_dir)
	cp $< $@


$(build_dir)/%.html: %.rst | $(build_dir)
	rst2sh5 $(rst2sh5_options) $< $@


$(build_dir):
	mkdir $@

$(data_dir): | $(build_dir)
	mkdir $@


.PHONY: clean
clean:
	$(RM) $(all_files)


# Disable default rules and suffixes
# (improve speed and avoid unexpected behaviour)
MAKEFLAGS := --no-builtin-rules
.SUFFIXES:


# EOF
