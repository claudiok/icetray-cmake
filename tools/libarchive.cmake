tooldef(libarchive
  include
  archive.h
  lib
  NONE
  archive
)

if(LIBARCHIVE_FOUND)
  set(LIBARCHIVEINI3PORTS_FOUND TRUE)
else()
  unset(LIBARCHIVE_CONFIG_ERROR)
  unset(LIBARCHIVE_INCLUDE_DIR)
  #colormsg(YELLOW "*** libarchive not found in \$I3_PORTS")
  #colormsg(YELLOW "*** Searching for 3rd party libarchive")

  find_package(LibArchive QUIET)

  if(LibArchive_INCLUDE_DIRS AND LibArchive_LIBRARIES)
    set(LIBARCHIVE_INCLUDE_DIR ${LibArchive_INCLUDE_DIRS})
    set(LIBARCHIVE_LIBRARIES ${LibArchive_LIBRARIES})
    set(LIBARCHIVE_FOUND TRUE CACHE BOOL "")
  endif(LibArchive_INCLUDE_DIRS AND LibArchive_LIBRARIES)

  if(NOT ${LIBARCHIVE_INCLUDE_DIR} MATCHES "-NOTFOUND")
    found_ok("archive.h found at ${LIBARCHIVE_INCLUDE_DIR}")
  endif(NOT ${LIBARCHIVE_INCLUDE_DIR} MATCHES "-NOTFOUND")

  if(NOT ${LIBARCHIVE_LIBRARIES} MATCHES "-NOTFOUND")
    found_ok(${LIBARCHIVE_LIBRARIES})
  endif(NOT ${LIBARCHIVE_LIBRARIES} MATCHES "-NOTFOUND")

endif()
