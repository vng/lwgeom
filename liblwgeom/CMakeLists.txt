
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

include_directories( ${GEOS_INCLUDE_DIR} )
include_directories( ${PROJ_INCLUDE_DIR} )

if( WIN32 )
  add_definitions( -D_CRT_SECURE_NO_DEPRECATE )
  add_definitions( -D_USE_MATH_DEFINES )
endif()

if( LWGEOM_USE_STATIC_LIBS )
  add_library( ${TARGET_NAME} STATIC ${PRIVATE_SOURCES} ${PRIVATE_HEADERS} )
else()
  add_library( ${TARGET_NAME} ${PRIVATE_SOURCES} ${PRIVATE_HEADERS} )
endif()
target_link_libraries( ${TARGET_NAME}
  ${GEOS_LIBRARY}
  ${PROJ_LIBRARY} )

include( ModuleInstall )
