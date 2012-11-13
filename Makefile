# Rebar:
REBAR_REPO = https://github.com/basho/rebar.git
REBAR_VERSION = 2.0.0
REBAR_REPO_DIR = rebar
REBAR = $(REBAR_REPO_DIR)/rebar

# Docs:
GENERATED_DOC_FILES = doc/*.html doc/edoc-info doc/erlang.png doc/*.css

# Design Docs:
DESIGN_DOCS_DIR = doc/design

.PHONY: doc clean clean-all

all: compile doc

$(REBAR): $(REBAR_REPO_DIR)
	cd $(REBAR_REPO_DIR); ./bootstrap

$(REBAR_REPO_DIR):
	git clone $(REBAR_REPO) $(REBAR_REPO_DIR)
	cd $(REBAR_REPO_DIR); git checkout -q $(REBAR_VERSION)

get-deps: $(REBAR)
	@$(REBAR) get-deps

compile: get-deps
	@$(REBAR) compile

check: compile
	@$(REBAR) xref

test: compile
	@$(REBAR) eunit skip_deps=true

doc: $(REBAR)
	@$(REBAR) doc skip_deps=true
	cd $(DESIGN_DOCS_DIR); $(MAKE) 

clean:
	@$(REBAR) clean
	$(RM) $(GENERATED_DOC_FILES)
	cd $(DESIGN_DOCS_DIR); $(MAKE) clean

clean-all: clean
	@$(REBAR) delete-deps
	rm -rf $(REBAR_REPO_DIR)
