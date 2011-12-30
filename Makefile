
CHROME_EXT_NAME=czechCharacter
CHROME_EXT_ZIP_ARCHIVE_NAME=$(CHROME_EXT_NAME).zip

all:
	@echo "make build-chrome-extension - Create zip archive for Chrome"

build-chrome-extension:
	rm -f $(CHROME_EXT_ZIP_ARCHIVE_NAME)
	mkdir $(CHROME_EXT_NAME)
	cp -r chrome-extension/* $(CHROME_EXT_NAME)/
	zip -r -q -9 $(CHROME_EXT_ZIP_ARCHIVE_NAME) $(CHROME_EXT_NAME)/
	rm -rf $(CHROME_EXT_NAME)
