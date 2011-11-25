YUM		= /usr/bin/yum
RPMBUILD	= /usr/bin/rpmbuild
BUILD_DIR	= /usr/src/redhat
SOURCE_DIR	= $(BUILD_DIR)/SOURCES

all: install_deps build update_repo

build: update_sources
	$(RPMBUILD) -v -ba nginx.spec

update_sources:
	cp -f SOURCES/* $(SOURCE_DIR)/

install_deps:
	$(YUM) install rpm-build pcre-devel pam-devel
