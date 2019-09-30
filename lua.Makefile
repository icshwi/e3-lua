#
#  Copyright (c) 2019    European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Monday, September 30 12:40:19 CEST 2019
# version : 0.0.1
#

## The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS


ifneq ($(strip $(ASYN_DEP_VERSION)),)
asyn_VERSION=$(ASYN_DEP_VERSION)
endif


## Exclude linux-ppc64e6500
#EXCLUDE_ARCHS += linux-ppc64e6500
#EXCLUDE_ARCHS += linux-corei7-poky

APP:=luaApp
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src

USR_CPPFLAGS += -DUSE_TYPED_RSET

TEMPLATES += $(wildcard $(APPDB)/*.db)
TEMPLATES += $(wildcard $(APPDB)/*.req)

#
#
DBDS     += $(APPSRC)/luaSupport.dbd
HEADERS  += $(APPSRC)/luaEpics.h
SOURCES  += $(APPSRC)/luaEpics.cpp
#
#
LUACORE:=$(APPSRC)/core
HEADERS += $(LUACORE)/lua.h
HEADERS += $(LUACORE)/lualib.h
HEADERS += $(LUACORE)/lauxlib.h
HEADERS += $(LUACORE)/luaconf.h
SOURCES += $(LUACORE)/lapi.c
SOURCES += $(LUACORE)/lauxlib.c
SOURCES += $(LUACORE)/lbaselib.c
SOURCES += $(LUACORE)/lbitlib.c
SOURCES += $(LUACORE)/lcode.c
SOURCES += $(LUACORE)/lcorolib.c
SOURCES += $(LUACORE)/lctype.c
SOURCES += $(LUACORE)/ldblib.c
SOURCES += $(LUACORE)/ldebug.c
SOURCES += $(LUACORE)/ldo.c
SOURCES += $(LUACORE)/ldump.c
SOURCES += $(LUACORE)/lfunc.c
SOURCES += $(LUACORE)/lgc.c
SOURCES += $(LUACORE)/linit.c
SOURCES += $(LUACORE)/liolib.c
SOURCES += $(LUACORE)/llex.c
SOURCES += $(LUACORE)/lmathlib.c
SOURCES += $(LUACORE)/lmem.c
SOURCES += $(LUACORE)/loadlib.c
SOURCES += $(LUACORE)/lobject.c
SOURCES += $(LUACORE)/lopcodes.c
SOURCES += $(LUACORE)/loslib.c
SOURCES += $(LUACORE)/lparser.c
SOURCES += $(LUACORE)/lstate.c
SOURCES += $(LUACORE)/lstring.c
SOURCES += $(LUACORE)/lstrlib.c
SOURCES += $(LUACORE)/ltable.c
SOURCES += $(LUACORE)/ltablib.c
SOURCES += $(LUACORE)/ltm.c
SOURCES += $(LUACORE)/lundump.c
SOURCES += $(LUACORE)/lutf8lib.c
SOURCES += $(LUACORE)/lvm.c
SOURCES += $(LUACORE)/lzio.c
#
#
LUASUPPORT:=$(APPSRC)/devSupport
HEADERS += $(LUASUPPORT)/devUtil.h
SOURCES += $(LUASUPPORT)/devLuaAi.c
SOURCES += $(LUASUPPORT)/devLuaAo.c
SOURCES += $(LUASUPPORT)/devLuaBi.c
SOURCES += $(LUASUPPORT)/devLuaBo.c
SOURCES += $(LUASUPPORT)/devLuaMbbi.c
SOURCES += $(LUASUPPORT)/devLuaMbbo.c
SOURCES += $(LUASUPPORT)/devLuaLongin.c
SOURCES += $(LUASUPPORT)/devLuaLongout.c
SOURCES += $(LUASUPPORT)/devLuaStringin.c
SOURCES += $(LUASUPPORT)/devLuaStringout.c
SOURCES += $(LUASUPPORT)/devUtil.cpp
#
#
LUASHELL:=$(APPSRC)/shell
HEADERS += $(LUASHELL)/luaShell.h
SOURCES += $(LUASHELL)/luaShell.cpp
#
#
LUALIBS:=$(APPSRC)/libs
SOURCES += $(LUALIBS)/lasynlib.cpp
SOURCES += $(LUALIBS)/lepicslib.cpp
#
#
LUAREC:=$(APPSRC)/rec
SOURCES += $(LUAREC)/luaSoft.c

## xxxRecord.dbd Local Codes 
DBDINC_SUFF = cpp
DBDINC_PATH = $(LUAREC)
DBDINC_SRCS = $(DBDINC_PATH)/luascriptRecord.$(DBDINC_SUFF)

## xxxRecord.dbd Generic Codes : BEGIN
DBDINC_DBDS = $(subst .$(DBDINC_SUFF),.dbd,   $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
DBDINC_HDRS = $(subst .$(DBDINC_SUFF),.h,     $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))
DBDINC_DEPS = $(subst .$(DBDINC_SUFF),$(DEP), $(DBDINC_SRCS:$(DBDINC_PATH)/%=%))

HEADERS += $(DBDINC_HDRS)
SOURCES += $(DBDINC_SRCS)

DBDS += $(LUAREC)/luascriptRecord.dbd


$(DBDINC_DEPS): $(DBDINC_HDRS)

.dbd.h:
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<

.PHONY: $(DBDINC_DEPS) .dbd.h
## xxxRecord.dbd END

#
#

SCRIPTS += $(wildcard ../iocsh/*.iocsh)


## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

db: 

.PHONY: db 

vlibs:

.PHONY: vlibs

