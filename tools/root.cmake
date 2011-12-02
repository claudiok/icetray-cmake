#
#  $Id$
#  
#  Copyright (C) 2007   Troy D. Straszheim  <troy@icecube.umd.edu>
#  and the IceCube Collaboration <http://www.icecube.wisc.edu>
#  
#  This file is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#  
option(USE_ROOT "Build with root" ON)
option(USE_CINT "Build dictionaries with rootcint" OFF)

if(NOT USE_ROOT AND USE_CINT)
  message(FATAL_ERROR "Cannot use rootcint without root")
endif(NOT USE_ROOT AND USE_CINT)

if(NOT USE_ROOT)
  message(STATUS "***************")
  message(STATUS "***************  CONFIGURED WITHOUT \"USE_ROOT\"")
  message(STATUS "***************")
  add_definitions(-UI3_USE_ROOT -UI3_USE_CINT)
  set(ROOT_INCLUDE_DIR "" CACHE STRING "USE_ROOT is OFF" FORCE)
  set(ROOT_BIN_DIR "" CACHE STRING "USE_ROOT is OFF" FORCE)
  # this is added to LD_LIBRARY_PATH
  set(ROOT_LIB_DIR "/USE_ROOT/IS/OFF" CACHE STRING "USE_ROOT is OFF" FORCE)
  set(ROOT_LIBRARIES "" CACHE STRING "USE_ROOT is OFF" FORCE)
  set(ROOTSYS "/USE_ROOT/IS/OFF" CACHE STRING "USE_ROOT is OFF" FORCE)

  # ROOT is nothing if USE_ROOT is off, so set ROOT_FOUND to fake out
  # modules that uncoditionally add USE_TOOLS root

  set(ROOT_FOUND TRUE)
else(NOT USE_ROOT)

  if(NOT ROOT_VERSION)
    foreach(ROOTVER 5.32.00 5.30.05 5.30.00 5.28.00h 5.28.00d 5.28.00 5.27.06b 5.26.00e 5.24.00b 5.20.00 5.18.00)
      if(IS_DIRECTORY ${I3_PORTS}/root-v${ROOTVER})
        set(ROOT_VERSION "${ROOTVER}")
        set(ROOT_${ROOT_VERSION}_LIBS Core Cint RIO Net Hist Graf Graf3d Gpad Tree Rint Postscript Matrix Physics MathCore Thread Minuit Gui)
        break()
      endif()
    endforeach()
  endif(NOT ROOT_VERSION)

  if(NOT ROOT_VERSION)
    message(FATAL_ERROR "Neither root 5.32.00 5.30.05 5.30.00 5.28.00h 5.28.00d 5.28.00 5.27.06b 5.26.00e 5.24.00b 5.20.00 5.18.00 found. Please install using ports.")
  endif(NOT ROOT_VERSION)

  set(ROOT_5.18.00_LIBS Core Cint RIO Net Hist Graf Graf3d Gpad Tree Rint Postscript Matrix Physics Minuit)

  add_definitions(-DI3_USE_ROOT -fno-strict-aliasing)
  if (USE_CINT)
    add_definitions(-DI3_USE_CINT)
  endif (USE_CINT)
  if(NOT ROOTSYS)
    set(ROOTSYS ${I3_PORTS}/root-v${ROOT_VERSION} CACHE STRING "The beloved ROOTSYS.")
  endif(NOT ROOTSYS)

  if (EXISTS ${ROOTSYS}/include/TXNetFile.h)
    find_library(FIND_ROOT_NETX_LIBRARY 
      Netx 
      PATHS ${ROOTSYS}/lib
      NO_DEFAULT_PATH)
  endif()

  if (FIND_ROOT_NETX_LIBRARY)
    set(ROOT_NETX_LIBRARY Netx)
    add_definitions(-DROOT_HAS_NETX)
  endif()

  tooldef (root 
    ${ROOTSYS}/include
    TObject.h
    ${ROOTSYS}/lib
    ${ROOTSYS}/bin
    ${ROOT_${ROOT_VERSION}_LIBS} ${ROOT_NETX_LIBRARY}
    )
  set(COMMON_TOOLS ${COMMON_TOOLS} root)
  set(ROOT_LIBRARIES ${ROOT_LIBRARIES} ${pthread_LIBRARIES})
endif(NOT USE_ROOT)
