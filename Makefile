include $(TOPDIR)/rules.mk

PKG_NAME:=domains-block-test
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=GPL-3.0-or-later

ifeq ("$(wildcard ../domains-block-test)", "")
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/karen07/domains-block-test.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
endif

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/domains-block-test
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libpcap
	TITLE:=Quick check if domains is blocked
	URL:=https://github.com/karen07/domains-block-test
endef

define Package/domains-block-test/description
	Quick check if domains is blocked
endef

ifneq ("$(wildcard ../domains-block-test)", "")
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ../domains-block-test/* $(PKG_BUILD_DIR)/
endef
endif

define Package/domains-block-test/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/domains-block-test $(1)/usr/bin/
endef

$(eval $(call BuildPackage,domains-block-test))
