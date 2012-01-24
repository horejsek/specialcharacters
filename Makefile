
SHELL=/bin/bash

CHROME_EXT_NAME=specialCharacter
CHROME_EXT_ZIP_ARCHIVE_NAME=$(CHROME_EXT_NAME).zip
CHROME_EXT_JS_DIR=chrome-extension/javascript/
CHROME_EXT_CLOSURE_LIBRARY=$(CHROME_EXT_JS_DIR)libs/closure-library/
CHROME_EXT_CLOSURE_COMPILER=$(CHROME_EXT_JS_DIR)libs/closure-compiler.jar
CHROME_EXT_COFFEE_SOURCES=$(CHROME_EXT_JS_DIR)*.coffee $(CHROME_EXT_JS_DIR)libs/*.coffee

all:
	@echo "make build-chrome-extension - Create zip archive for Chrome"
	@echo "make compile-chrome-extension - Compile Chrome Extension"
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

	python $(CHROME_EXT_CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CHROME_EXT_CLOSURE_LIBRARY) \
	    --compiler_jar $(CHROME_EXT_CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)functions.js \
	    --input $(CHROME_EXT_JS_DIR)characters.js \
	    --input $(CHROME_EXT_JS_DIR)contextMenu.js \
	    --input $(CHROME_EXT_JS_DIR)background.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)background.min.js;
	python $(CHROME_EXT_CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CHROME_EXT_CLOSURE_LIBRARY) \
	    --compiler_jar $(CHROME_EXT_CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)libs/closure-i18n.js \
	    --input $(CHROME_EXT_JS_DIR)functions.js \
	    --input $(CHROME_EXT_JS_DIR)characters.js \
	    --input $(CHROME_EXT_JS_DIR)contextMenu.js \
	    --input $(CHROME_EXT_JS_DIR)options.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)options.min.js;
	python $(CHROME_EXT_CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CHROME_EXT_CLOSURE_LIBRARY) \
	    --compiler_jar $(CHROME_EXT_CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)libs/closure-i18n.js \
	    --input $(CHROME_EXT_JS_DIR)functions.js \
	    --input $(CHROME_EXT_JS_DIR)characters.js \
	    --input $(CHROME_EXT_JS_DIR)popup.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)popup.min.js;
	python $(CHROME_EXT_CLOSURE_LIBRARY)closure/bin/calcdeps.py \
	    --path $(CHROME_EXT_CLOSURE_LIBRARY) \
	    --compiler_jar $(CHROME_EXT_CLOSURE_COMPILER) \
	    --input $(CHROME_EXT_JS_DIR)contentscript.js \
	    --output_mode compiled > $(CHROME_EXT_JS_DIR)contentscript.min.js;

clean:
	rm -rf $(CHROME_EXT_NAME) $(CHROME_EXT_ZIP_ARCHIVE_NAME)
	find $(CHROME_EXT_JS_DIR)* -maxdepth 0 -type f -not -name *.coffee | xargs rm -f

install-libs:
	apt-get install nodejs coffeescript
