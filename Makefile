#
# Copyright (C) 2007-2024 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpcre
PKG_VERSION:=8.45
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://ftp.pcre.org/pub/pcre/
PKG_HASH:=4dae6fdcd2bb01d893f4f7d9271c99042b349ec3ee6828b869b3b2e0846c7d44

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/libpcre
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Perl-compatible regular expression library
  URL:=https://www.pcre.org/
endef

define Package/libpcre/description
  PCRE is a library of functions to support regular expressions whose syntax
  and semantics are as close as possible to those of the Perl 5 language.
endef

define Build/Configure
  $(call Build/Configure/Default, --enable-utf --enable-unicode-properties)
endef

define Build/InstallDev
  $(INSTALL_DIR) $(1)/usr/include
  $(CP) $(PKG_BUILD_DIR)/pcre.h $(1)/usr/include/
  $(CP) $(PKG_BUILD_DIR)/pcre_internal.h $(1)/usr/include/
  $(INSTALL_DIR) $(1)/usr/lib
  $(CP) $(PKG_BUILD_DIR)/.libs/libpcre.so* $(1)/usr/lib/
  $(INSTALL_DIR) $(1)/usr/lib/pkgconfig
  $(CP) $(PKG_BUILD_DIR)/libpcre.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libpcre/install
  $(INSTALL_DIR) $(1)/usr/lib
  $(CP) $(PKG_BUILD_DIR)/.libs/libpcre.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libpcre))

