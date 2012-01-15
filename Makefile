
CHROME_EXT_NAME=czechCharacter
CHROME_EXT_ZIP_ARCHIVE_NAME=$(CHROME_EXT_NAME).zip
CHROME_EXT_COFFEE_SOURCES=chrome-extension/javascript/*.coffee

all:
	@echo "make build-chrome-extension - Create zip archive for Chrome"
	@echo "make compile-chrome-extension - Compile Chrome Extension"

build-chrome-extension: compile-chrome-extension
	rm -f $(CHROME_EXT_ZIP_ARCHIVE_NAME)
	mkdir $(CHROME_EXT_NAME)
	cp -r chrome-extension/* $(CHROME_EXT_NAME)/
	rm -f $(CHROME_EXT_NAME)/javascript/*.coffee
	zip -r -q -9 $(CHROME_EXT_ZIP_ARCHIVE_NAME) $(CHROME_EXT_NAME)/
	rm -rf $(CHROME_EXT_NAME)

compile-chrome-extension:
	coffee -cb $(CHROME_EXT_COFFEE_SOURCES)
