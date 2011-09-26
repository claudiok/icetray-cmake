# - Try to find log4cplus
# Once done this will define
#  LOG4CPLUS_FOUND         - System has log4cplus
#  LOG4CPLUS_INCLUDE_DIRS  - The log4cplus include directories
#  LOG4CPLUS_LIBRARIES     - The libraries needed to use log4cplus
#
# Prior to calling this find module, one can set the variable
# LOG4CPLUS_SEARCH_DIRS to specify hints for searching for the include
# files and libraries.
#  file(glob LOG4CPLUS_SEARCH_DIRS $ENV{I3_PORTS}/*/log4cplus-*)
#  find_package(Log4Cplus)
#
# This module makes no attempt to specify or respect versions. If you
# have multiple versions of log4cplus installed, and/or installed in
# an inconsistent manner, this module could find mismatching headers and
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


if(LOG4CPLUS_SEARCH_DIRS)
  set(_l4cpd ${LOG4CPLUS_SEARCH_DIRS})
endif()

find_path(LOG4CPLUS_INCLUDE_DIR log4cplus/logger.h
  HINTS ${_l4cpd}
)

find_library(LOG4CPLUS_LIBRARY NAMES log4cplus
  HINTS ${_l4cpd}
)

set(LOG4CPLUS_LIBRARIES ${LOG4CPLUS_LIBRARY} )
set(LOG4CPLUS_INCLUDE_DIRS ${LOG4CPLUS_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Log4Cplus DEFAULT_MSG
                                  LOG4CPLUS_LIBRARY LOG4CPLUS_INCLUDE_DIR)
mark_as_advanced(LOG4CPLUS_LIBRARY LOG4CPLUS_INCLUDE_DIR)
