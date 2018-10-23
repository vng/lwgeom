
cmake_minimum_required( VERSION 3.0.0 )
project( lwgeom )

# Get version info
set( _versionFile "${CMAKE_CURRENT_SOURCE_DIR}/Version.config" )
file( READ "${_versionFile}" _versionContents )

string( REGEX MATCH "POSTGIS_MAJOR_VERSION=([0-9]*)" _ ${_versionContents} )
set( POSTGIS_MAJOR_VERSION ${CMAKE_MATCH_1} )
string( REGEX MATCH "POSTGIS_MINOR_VERSION=([0-9]*)" _ ${_versionContents} )
set( POSTGIS_MINOR_VERSION ${CMAKE_MATCH_1} )
string( REGEX MATCH "POSTGIS_MICRO_VERSION=([0-9]*)" _ ${_versionContents} )
set( POSTGIS_MICRO_VERSION ${CMAKE_MATCH_1} )
set( POSTGIS_LIB_VERSION
  "${POSTGIS_MAJOR_VERSION}.${POSTGIS_MINOR_VERSION}.${POSTGIS_MICRO_VERSION}" )

set( ${CMAKE_PROJECT_NAME}_MAJOR_VERSION ${POSTGIS_MAJOR_VERSION} )
set( ${CMAKE_PROJECT_NAME}_MINOR_VERSION ${POSTGIS_MINOR_VERSION} )
set( ${CMAKE_PROJECT_NAME}_MICRO_VERSION ${POSTGIS_MICRO_VERSION} )
set( ${CMAKE_PROJECT_NAME}_VERSION ${POSTGIS_LIB_VERSION} )
message( STATUS
  "Configuring ${CMAKE_PROJECT_NAME}: v${${CMAKE_PROJECT_NAME}_VERSION}\n" )

set( INSTALL_LIBDIR lib )
set( INSTALL_BINDIR bin )
set( INSTALL_INCDIR include )
set( INSTALL_SHRDIR share )

if( WIN32 )
  string( REGEX REPLACE "(^| )[/-]D *NDEBUG($| )" " "
    CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" )
  string( REGEX REPLACE "(^| )[/-]D *NDEBUG($| )" " "
    CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}" )

  if( MSVC )
    if( ${CMAKE_GENERATOR} MATCHES "Win64" )
      set( VC_PLATFORM "x64" )
    else()
      set( VC_PLATFORM "Win32" )
    endif()
    message( STATUS "VC++ Platform: ${VC_PLATFORM}\n" )
  endif()
endif()

# Set a default build type if none was specified
if( NOT WIN32 AND NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Set build type" FORCE )
endif()

# Update cmake module path
set( CMAKE_MODULE_PATH
  "${PROJECT_SOURCE_DIR}/CMakeModules" ${CMAKE_MODULE_PATH} )

# Static or shared libs
set( LWGEOM_USE_STATIC_LIBS OFF CACHE BOOL "Whether to use static libs" )
set( GEOS_DIR CACHE PATH "Location of GEOS installation" )
set( PROJ_DIR CACHE PATH "Location of PROJ installation" )

# GEOS
if( LWGEOM_USE_STATIC_LIBS )
  set( GEOS_USE_STATIC_LIBS ON )
endif()
find_package( GEOS 3.5 REQUIRED )
set( POSTGIS_GEOS_VERSION "${GEOS_VERSION_MAJOR}${GEOS_VERSION_MINOR}" )

# PROJ
if( LWGEOM_USE_STATIC_LIBS )
  set( PROJ_USE_STATIC_LIBS ON )
endif()
find_package( PROJ 4.9 REQUIRED )

# Configure files
configure_file( ${PROJECT_SOURCE_DIR}/postgis_config.h.in
  ${PROJECT_SOURCE_DIR}/postgis_config.h @ONLY )

set( SRID_MAX 999999 )
set( SRID_USR_MAX 998999 )
configure_file( ${PROJECT_SOURCE_DIR}/liblwgeom/liblwgeom.h.in
  ${PROJECT_SOURCE_DIR}/liblwgeom/liblwgeom.h @ONLY )

# Liblwgeom
add_subdirectory( liblwgeom )
install(
  FILES postgis_config.h postgis_svn_revision.h
  DESTINATION ${INSTALL_INCDIR} )
