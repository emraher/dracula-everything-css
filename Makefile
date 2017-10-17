# ** Variables
VPATH = .:sites
CSS_DIR := css
COLORS := dracula

COMMON_FILES := $(wildcard styl/*.styl) sites/generic.styl
SITES := $(patsubst sites/%.styl,%,$(wildcard sites/*))

# ** Functions
make_site = for color in $(COLORS); do stylus --include styl --import styl/$$color.styl --import styl -p sites/$(1).styl >$(CSS_DIR)/$(1).css; done

# ** Rules
.PHONY: all
all: $(SITES)

$(CSS_DIR):
	mkdir $(CSS_DIR)

# Make all-sites explicitly depend on everything so it will be rebuilt when anything changes
$(CSS_DIR)/all-sites-*.css: $(wildcard sites/*)

$(SITES): %: $(CSS_DIR)/%.css

$(foreach color, $(COLORS), $(CSS_DIR)/%.css): sites/%.styl $(COMMON_FILES) | $(CSS_DIR)
	$(call make_site,$*)
