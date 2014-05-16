libgeom-file-list = geom_ctl  geom_getxml  geom_stats  geom_util  geom_xml2tree
libgeom-objects = $(foreach file, $(libgeom-file-list), bsd/lib/libgeom/$(file).o)

define libgeom-includes
  bsd/lib/libgeom
  bsd/include
  bsd
  bsd/sys
endef

cflags-libgeom-include = $(foreach path, $(strip $(libgeom-includes)), -isystem $(src)/$(path))

$(libgeom-objects): local-includes += $(cflags-libgeom-include)

# disable the main bsd include search order, we want it before osv but after solaris
#$(libgeom-objects): post-includes-bsd =

$(libgeom-objects): kernel-defines =

$(libgeom-objects): CFLAGS += -Wno-unknown-pragmas

libgeom.so: $(libgeom-objects)
	$(makedir)
	$(q-build-so)

