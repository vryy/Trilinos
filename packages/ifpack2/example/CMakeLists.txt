TRIBITS_CONFIGURE_FILE(${PACKAGE_NAME}_config.h)
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})

TRIBITS_ADD_EXECUTABLE(
  ex1
  SOURCES ex1.cpp
)

IF (Tpetra_INST_DOUBLE)
TRIBITS_ADD_EXECUTABLE(
  RelaxationWithEquilibration
  SOURCES RelaxationWithEquilibration.cpp
)
ENDIF()


TRIBITS_ADD_EXECUTABLE(
  BlockTriDiagonalSolver
  SOURCES BlockTriDi.cpp
)


 TRIBITS_ADD_TEST(
    BlockTriDiagonalSolver
    NAME BlockTriDiExample
    ARGS ""
    COMM serial mpi
    NUM_MPI_PROCS 1-4
    STANDARD_PASS_OUTPUT
    )