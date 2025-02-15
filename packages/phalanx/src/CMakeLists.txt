#
# A) Package-specific configuration options
#

TRIBITS_CONFIGURE_FILE(${PACKAGE_NAME}_config.hpp)

#
# B) Define the header and source files (and directories)
#

SET(HEADERS "")
SET(SOURCES "")

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})

SET(HEADERS ${HEADERS}
  ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}_config.hpp
  )

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

APPEND_GLOB(HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)
APPEND_GLOB(SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

#
# C) Define the targets for package's library(s)
#

# CMake >= 3.17 uses FindCUDAToolkit
IF(CMAKE_VERSION VERSION_LESS "3.17.0" AND PHX_KOKKOS_DEVICE_TYPE_CUDA)
    IF( TPL_ENABLE_MPI )
        CUDA_INCLUDE_DIRECTORIES( ${MPI_BASE_DIR}/include )
    ENDIF()

    CUDA_INCLUDE_DIRECTORIES( ${KokkosCore_INCLUDE_DIRS}
                              ${Phalanx_INCLUDE_DIRS})
ENDIF()

TRIBITS_ADD_LIBRARY(
  phalanx
  HEADERS ${HEADERS}
  SOURCES ${SOURCES}
  DEPLIBS ${Phalanx_CUDA_LIBRARY}
  )

