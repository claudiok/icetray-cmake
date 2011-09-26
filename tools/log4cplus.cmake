#
#  $Id$
#
#  Copyright (C) 2007-9
#  Troy D. Straszheim  <troy@icecube.umd.edu>
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

option(PRINTF_LOGGING "Log via 'printf', not log4cplus.  For debugging when things go truly crazy.  See also PRINTF_LOGGING_LEVEL." OFF)
set(PRINTF_LOGGING_LEVEL LOG_INFO CACHE STRING "Logging level PRINTF_LOGGING is OFF. Choices are those that appear in I3Logging.h")

if(PRINTF_LOGGING)
  add_definitions(-DI3_PRINTF_LOGGING -DI3_PRINTF_LOGGING_LEVEL=${PRINTF_LOGGING_LEVEL})
  tooldef (log4cplus
    NONE
    NONE
    NONE
    NONE
    NONE
    )
else(PRINTF_LOGGING)  # just use log4cplus

colormsg("")
colormsg(HICYAN "log4cplus")
file(GLOB LOG4CPLUS_SEARCH_DIRS "${I3_PORTS}/*/log4cplus-1.0.4" "${I3_PORTS}/*/log4cplus-1.0.2")
find_package(Log4Cplus QUIET)

if(LOG4CPLUS_FOUND)
  found_ok("log4cplus/logger.h found at ${LOG4CPLUS_INCLUDE_DIRS}")
  found_ok("${LOG4CPLUS_LIBRARIES}")
endif(LOG4CPLUS_FOUND)

endif(PRINTF_LOGGING)

