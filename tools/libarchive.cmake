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
  unset(LIBARCHIVE_FOUND)
  unset(LIBARCHIVE_FOUND CACHE)
  unset(LIBARCHIVE_CONFIG_ERROR)
  unset(LIBARCHIVE_INCLUDE_DIR)
  #colormsg(YELLOW "*** libarchive not found in \$I3_PORTS")
  #colormsg(YELLOW "*** Searching for 3rd party libarchive")

  find_package(LibArchive QUIET)

  if(LibArchive_FOUND)
    set(LIBARCHIVE_INCLUDE_DIR ${LibArchive_INCLUDE_DIRS})
    set(LIBARCHIVE_LIBRARIES ${LibArchive_LIBRARIES})
    set(LIBARCHIVE_FOUND TRUE CACHE BOOL "")
  endif(LibArchive_FOUND)

  if(NOT ${LIBARCHIVE_INCLUDE_DIR} MATCHES "-NOTFOUND")
    found_ok("archive.h found at ${LIBARCHIVE_INCLUDE_DIR}")
  endif(NOT ${LIBARCHIVE_INCLUDE_DIR} MATCHES "-NOTFOUND")

if(LIBARCHIVE_INCLUDE_DIR AND LIBARCHIVE_LIBRARIES)
  set(LIBARCHIVE_FOUND TRUE CACHE BOOL "")
  add_custom_command(TARGET install__libs
    PRE_BUILD
    COMMAND mkdir -p ${CMAKE_INSTALL_PREFIX}/lib/tools
    COMMAND ${CMAKE_SOURCE_DIR}/cmake/install_shlib.py ${LIBARCHIVE_LIBRARIES} ${CMAKE_INSTALL_PREFIX}/lib/tools)
endif(LIBARCHIVE_INCLUDE_DIR AND LIBARCHIVE_LIBRARIES)
