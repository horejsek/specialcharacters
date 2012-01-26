
SHELL=/bin/bash

CLOSURE_LIBRARY=libs/closure-library/
CLOSURE_COMPILER=libs/closure-compiler.jar

CHROME_EXT_NAME=specialCharacter
CHROME_EXT_ZIP_ARCHIVE_NAME=$(CHROME_EXT_NAME).zip
CHROME_EXT_JS_DIR=chrome-extension/javascript/
CHROME_EXT_COFFEE_SOURCES=$(CHROME_EXT_JS_DIR)*.coffee $(CHROME_EXT_JS_DIR)libs/*.coffee

all:
	@echo "make build-chrome-extension - Create zip archive for Chrome"
	@echo "make compile-chrome-extension - Compile Chrome Extension"
	@echo "make localdev - Init submodules, git-hooks, ..."
	@echo "make clean - Clean directory from compiled and building files"
	@echo "make install-libs - Install libs for develop"

build-chrome-extension: clean compile-chrome-extension
	mkdir $(CHROME_EXT_NAME)
	cp -r chrome-extension/* $(CHROME_EXT_NAME)/
	find $(CHROME_EXT_NAME)/javascript/* -not -name *.min.js | xargs rm -rf
	zip -r -q -9 $(CHROME_EXT_ZIP_ARCHIVE_NAME) $(CHROME_EXT_NAME)/
	rm -rf $(CHROME_EXT_NAME)

compile-chrome-extension:
	coffee -cb $(CHROME_EXT_COFFEE_SOURCES)

	python $(CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CLOSURE_LIBRARY) \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)libs/closure-i18n.js \
	    --input $(CHROME_EXT_JS_DIR)functions.js \
	    --input $(CHROME_EXT_JS_DIR)characters.js \
	    --input $(CHROME_EXT_JS_DIR)contextMenu.js \
	    --input $(CHROME_EXT_JS_DIR)background.js \
	    --input $(CHROME_EXT_JS_DIR)popup.js \
	    --input $(CHROME_EXT_JS_DIR)options.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)specialCharacters.min.js;
	python $(CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CLOSURE_LIBRARY) \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)contentscript.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)contentscript.min.js;

localdev:
	git submodule init
	git submodule update

clean:
	rm -rf $(CHROME_EXT_NAME) $(CHROME_EXT_ZIP_ARCHIVE_NAME)
	find $(CHROME_EXT_JS_DIR)* -type f -not -name *.coffee | xargs rm -f

install-libs:
	apt-get install nodejs coffeescript
