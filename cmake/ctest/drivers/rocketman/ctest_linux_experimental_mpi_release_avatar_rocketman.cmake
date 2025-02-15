# @HEADER
# ************************************************************************
#
#            Trilinos: An Object-Oriented Solver Framework
#                 Copyright (2001) Sandia Corporation
#
#
# Copyright (2001) Sandia Corporation. Under the terms of Contract
# DE-AC04-94AL85000, there is a non-exclusive license for use of this
# work by or on behalf of the U.S. Government.  Export of this program
# may require a license from the United States Government.
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the Corporation nor the names of the
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY SANDIA CORPORATION "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SANDIA CORPORATION OR THE
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# NOTICE:  The United States Government is granted for itself and others
# acting on its behalf a paid-up, nonexclusive, irrevocable worldwide
# license in this data to reproduce, prepare derivative works, and
# perform publicly and display publicly.  Beginning five (5) years from
# July 25, 2001, the United States Government is granted for itself and
# others acting on its behalf a paid-up, nonexclusive, irrevocable
# worldwide license in this data to reproduce, prepare derivative works,
# distribute copies to the public, perform publicly and display
# publicly, and to permit others to do so.
#
# NEITHER THE UNITED STATES GOVERNMENT, NOR THE UNITED STATES DEPARTMENT
# OF ENERGY, NOR SANDIA CORPORATION, NOR ANY OF THEIR EMPLOYEES, MAKES
# ANY WARRANTY, EXPRESS OR IMPLIED, OR ASSUMES ANY LEGAL LIABILITY OR
# RESPONSIBILITY FOR THE ACCURACY, COMPLETENESS, OR USEFULNESS OF ANY
# INFORMATION, APPARATUS, PRODUCT, OR PROCESS DISCLOSED, OR REPRESENTS
# THAT ITS USE WOULD NOT INFRINGE PRIVATELY OWNED RIGHTS.
#
# ************************************************************************
# @HEADER


INCLUDE("${CTEST_SCRIPT_DIRECTORY}/TrilinosCTestDriverCore.rocketman.gcc.cmake")

#
# Set the options specific to this build case
#

# The variable BUILD_DIR_NAME is based COMM_TYPE, BUILD_TYPE, and BUILD_NAME_DETAILS.
# Tribits creates the variable listed under "Build Name" by prepending the OS type and compiler
# details to BUILD_DIR_NAME.
SET(COMM_TYPE MPI)
SET(BUILD_TYPE RELEASE)
SET(BUILD_NAME_DETAILS AVATAR)
SET(CTEST_BUILD_FLAGS     "-j35 -i" )

SET(CTEST_PARALLEL_LEVEL 8)
SET(CTEST_TEST_TYPE Experimental)
SET(Trilinos_TRACK  Experimental)  # Set the CDash track to Nightly
SET(CTEST_TEST_TIMEOUT 14400) # twice the default value, for valgrind
SET(CTEST_DO_MEMORY_TESTING FALSE)

SET(Trilinos_PACKAGES TrilinosCouplings MueLu )

# If true, this option yields faster builds. In that case, however, it won't disable any upstream package that fails to compile.
SET(Trilinos_CTEST_DO_ALL_AT_ONCE TRUE)

# GH 20230111: changing Rocketman to pull from the sandialabs Avatar repo, https://github.com/sandialabs/avatar.git
# GH         : since Avatar depends on gsl version 1.16, pull the gsl source from https://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz
# GH         : it doesn't seem like Avatar actually need gsl, despite listing it as required in the cmake configure script...

SET(EXTRA_CONFIGURE_OPTIONS
  "-DTrilinos_ENABLE_EXPLICIT_INSTANTIATION=ON"
  "-DTrilinos_ENABLE_DEPENDENCY_UNIT_TESTS=OFF"
  "-DTPL_ENABLE_SuperLU=ON"
  "-DTPL_ENABLE_Netcdf=ON"
  "-DTPL_ENABLE_HDF5=ON"
  "-DTPL_ENABLE_Avatar=ON"
  "-DTPL_ENABLE_Matio=OFF"
  "-DTPL_ENABLE_Boost=ON"
  "-DTPL_ENABLE_BoostLib=ON"
  "-DTPL_ENABLE_X11=OFF"
  "-DAvatar_INCLUDE_DIRS=/home/gbharpe/Programming/cpp/avatar/avatar-source/src"
  "-DAvatar_LIBRARY_DIRS=/home/gbharpe/Programming/cpp/avatar/avatar-build/src"
  "-DTPL_Avatar_LIBRARIES=/home/gbharpe/Programming/cpp/avatar/avatar-build/src/libavatar.a"
)

#
# Set the rest of the system-specific options and run the dashboard build/test
#

TRILINOS_SYSTEM_SPECIFIC_CTEST_DRIVER()
