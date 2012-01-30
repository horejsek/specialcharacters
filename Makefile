
SHELL=/bin/bash

CLOSURE_LIBRARY=libs/closure-library/
CLOSURE_COMPILER=libs/closure-compiler.jar

CHROME_EXT_NAME=specialCharacter
CHROME_EXT_ZIP_ARCHIVE_NAME=$(CHROME_EXT_NAME).zip
CHROME_EXT_JS_DIR=chrome-extension/javascript/
CHROME_EXT_COFFEE_SOURCES=$(CHROME_EXT_JS_DIR)*.coffee $(CHROME_EXT_JS_DIR)*/*.coffee

all:
	@echo "chrome-extension:"
	@echo "make test-chrome-extension - Test Chrome Extension"
	@echo "make compile-chrome-extension - Compile Chrome Extension"
	@echo "make build-chrome-extension - Create zip archive for Chrome"
	@echo "global:"
	@echo "make clean - Clean directory from compiled and building files"
	@echo "make localdev - Init submodules, git-hooks, ..."
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
	    --input $(CHROME_EXT_JS_DIR)libs/functions.js \
	    --input $(CHROME_EXT_JS_DIR)character/character.js \
	    --input $(CHROME_EXT_JS_DIR)characters/characters.js \
	    --input $(CHROME_EXT_JS_DIR)contextMenu/contextMenu.js \
	    --input $(CHROME_EXT_JS_DIR)background/background.js \
	    --input $(CHROME_EXT_JS_DIR)popup/popup.js \
	    --input $(CHROME_EXT_JS_DIR)options/options.js \
	    --output_mode compiled \
	    > $(CHROME_EXT_JS_DIR)specialCharacters.min.js;
	python $(CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CLOSURE_LIBRARY) \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)contentscript/contentscript.js \
	    --output_mode compiled \
	    > $(CHROME_EXT_JS_DIR)contentscript.min.js;

test-chrome-extension:
	coffee -cb $(CHROME_EXT_COFFEE_SOURCES)
	python $(CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --dep $(CLOSURE_LIBRARY) \
	    --path $(CHROME_EXT_JS_DIR) \
	    --output_mode deps \
	    > $(CHROME_EXT_JS_DIR)test_deps.js;
	chromium-browser --allow-file-access-from-files $(CHROME_EXT_JS_DIR)all_tests.html

clean:
	rm -rf $(CHROME_EXT_NAME) $(CHROME_EXT_ZIP_ARCHIVE_NAME)
	find $(CHROME_EXT_JS_DIR) -type f -name *.js | xargs rm -f

localdev:
	git submodule init
	git submodule update

install-libs:
	apt-get install nodejs coffeescript chromium-browser
