#---
# File: FindPROJ.cmake
#
# Find the native PROJ includes and libraries.
#
# This module defines:
#
# PROJ_INCLUDE_DIR, where to find geos.h, etc.
# PROJ_LIBRARY, libraries to link against to use PROJ.
# PROJ_FOUND, true if found, false if one of the above are not found.

# Find include path
find_path( PROJ_INCLUDE_DIR
  NAMES
    proj_api.h
  HINTS
    ${PROJ_DIR}/include
  PATHS
    /usr/include
    /usr/local/include
    /opt/local/include
    /sw/include
  PATH_SUFFIXES
    proj4 )

# Find PROJ library
find_library( PROJ_LIBRARY
  NAMES
    proj
    proj_i
  HINTS
    ${PROJ_DIR}/lib
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/local/lib
    /sw/lib )

# Set the PROJ_LIBRARY
if( PROJ_LIBRARY )
  #set( PROJ_LIBRARY ${PROJ_LIBRARY} CACHE STRING INTERNAL )
endif()

# Set PROJ_FOUND if variables are valid
include( FindPackageHandleStandardArgs )
find_package_handle_standard_args( PROJ
  DEFAULT_MSG PROJ_LIBRARY PROJ_INCLUDE_DIR )

if( PROJ_FOUND )
  if( NOT PROJ_FIND_QUIETLY )
    message( STATUS "Found PROJ..." )
   endif()
else()
  if( NOT PROJ_FIND_QUIETLY )
    message( WARNING "Could not find PROJ" )
   endif()
endif()

if( NOT PROJ_FIND_QUIETLY )
  message( STATUS "PROJ_INCLUDE_DIR=${PROJ_INCLUDE_DIR}" )
  message( STATUS "PROJ_LIBRARY=${PROJ_LIBRARY}" )
endif()
