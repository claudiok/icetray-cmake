# - Try to find root
# Once done this will define
#  ROOT_FOUND         - System has log4cplus
#  ROOT_INCLUDE_DIRS  - The root include directories
#  ROOT_LIBRARIES     - The libraries needed to use root
#
# This module makes no attempt to specify or respect versions. If you
# have multiple versions of root installed, and/or installed in an
# inconsistent manner, this module could find mismatching headers and
# libraries.

#=============================================================================
# Copyright 2011 Don La Dieu
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

if(NOT ROOT_FOUND)
  find_program(ROOT_CONFIG root-config)
  if(${ROOT_CONFIG} MATCHES ".*-NOTFOUND")
    set(ROOT_FOUND FALSE)
    colormsg(RED "Install Root and make sure it is in the PATH")
  else()
    execute_process(
      COMMAND         ${ROOT_CONFIG} --incdir
      OUTPUT_VARIABLE ROOT_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(
      COMMAND         ${ROOT_CONFIG} --libs
      OUTPUT_VARIABLE ROOT_LIBRARY
      OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(ROOT_LIBRARIES ${ROOT_LIBRARY} )
    set(ROOT_INCLUDE_DIRS ${ROOT_INCLUDE_DIR} )

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(Root DEFAULT_MSG
      ROOT_LIBRARY ROOT_INCLUDE_DIR)
    mark_as_advanced(ROOT_LIBRARY ROOT_INCLUDE_DIR)
    colormsg(CYAN "Found Root: ${ROOT_FOUND}")

  endif()
endif(NOT ROOT_FOUND)
