
CHROME_EXT_NAME=specialCharacter
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

install-libs: install-dev-libs install-nodejs install-coffeescript

install-dev-libs:
	apt-get install g++ curl libssl-dev apache2-utils

install-nodejs:
	wget http://github.com/joyent/node/tarball/master -O nodejs.tar.gz
	tar xvzf nodejs.tar.gz
	cd `ls -dt *node*/ | head -1`; ./configure; make; make install
	rm -rf nodejs.tar.gz `ls -dt *node*/ | head -1`

install-coffeescript:
	wget http://github.com/jashkenas/coffee-script/tarball/master -O coffescript.tar.gz
	tar xvzf coffescript.tar.gz
	`ls -dt *coffee-script*/ | head -1`/bin/cake install
	rm -rf coffescript.tar.gz `ls -dt *coffee-script*/ | head -1`
