
set( SRID_MAX 999999 )
set( SRID_USR_MAX 998999 )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/liblwgeom.h.in
  ${CMAKE_CURRENT_SOURCE_DIR}/liblwgeom.h @ONLY )

file( GLOB HEADERS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.h" )
list( REMOVE_ITEM HEADERS "lwgeom_sfcgal.h" )
file( GLOB SOURCES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.c" )
list( REMOVE_ITEM SOURCES "lwgeom_sfcgal.c" )

set( TARGET_NAME liblwgeom )
set( TARGET_VERSION ${${CMAKE_PROJECT_NAME}_VERSION} )
set( TARGET_EXPORT ${CMAKE_PROJECT_NAME}Targets )
set( TARGET_CATEGORY Lib )
set( TARGET_LANGUAGE C )
set( PRIVATE_HEADERS ${HEADERS} )
set( PUBLIC_HEADERS ${HEADERS} )
set( PRIVATE_SOURCES ${SOURCES} )
set( INCDIR_NAME "liblwgeom" )

if( MSVC )
  add_definitions( -D_CRT_SECURE_NO_DEPRECATE )
  add_definitions( -D_USE_MATH_DEFINES )

  if( BUILD_SHARED_LIBS )
    set( CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON )
  endif()
endif()

add_library( ${TARGET_NAME}
  ${PRIVATE_SOURCES}
  ${PRIVATE_HEADERS} )
target_include_directories( ${TARGET_NAME} PUBLIC
  ${GEOS_INCLUDE_DIR}
  ${PROJ_INCLUDE_DIR}
  "$<$<BOOL:${JSON_C_FOUND}>:${JSON_C_INCLUDE_DIR}>" )
target_link_libraries( ${TARGET_NAME}
  ${GEOS_LIBRARY}
  ${PROJ_LIBRARY}
  "$<$<BOOL:${JSON_C_FOUND}>:${JSON_C_LIBRARY}>" )

include( ModuleInstall )
