cmake_minimum_required(VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
# --- custom targets: ---
if (NOT TARGET distclean)
   INCLUDE( cmake/Modules/TargetDistclean.cmake OPTIONAL)
endif (NOT TARGET distclean)

# enable @rpath in the install name for any shared library being built
set(CMAKE_MACOSX_RPATH 1)

project (TIMER)
# The version number.
set (TIMER_VERSION_MAJOR 2)
set (TIMER_VERSION_MINOR 0.7)
set (TIMER_VERSION "${TIMER_VERSION_MAJOR}.${TIMER_VERSION_MINOR}")

if (NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE RelWithDebInfo)
endif(NOT CMAKE_BUILD_TYPE)

# uncomment to build debug
#set(CMAKE_BUILD_TYPE Debug)

#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
   # using Clang
   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -ftree-vectorize")
   set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall -g -O0 -Wextra")
   set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
   # using GCC
   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -ftree-vectorize")
   set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall -g -O0 -Wextra")
   set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Intel")
   # using Intel C++
   set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0")
   set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3")
elseif (CMAKE_C_COMPILER_ID MATCHES "XL")
   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
   set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0")
   set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3")
endif()

########### global settings ###############
set(H_SRCS timer.h)
set(C_SRCS timer.c)

set(timer_LIB_SRCS ${C_SRCS} ${H_SRCS})

########### timer target ###############
add_library(timer SHARED ${timer_LIB_SRCS})

set_target_properties(timer PROPERTIES VERSION ${TIMER_VERSION} SOVERSION ${TIMER_VERSION_MAJOR})
install(TARGETS timer DESTINATION lib)

########### mptimer target ###############
if(OPENMP_FOUND)
   add_library(mptimer SHARED ${timer_LIB_SRCS})

   set_target_properties(mptimer PROPERTIES VERSION ${TIMER_VERSION} SOVERSION ${TIMER_VERSION_MAJOR})
   set_target_properties(mptimer PROPERTIES COMPILE_FLAGS ${OpenMP_C_FLAGS})
   set_target_properties(mptimer PROPERTIES COMPILE_FLAGS ${OpenMP_CXX_FLAGS})
   set_target_properties(mptimer PROPERTIES LINK_FLAGS ${OpenMP_C_FLAGS})

   install(TARGETS mptimer DESTINATION lib)
endif(OPENMP_FOUND)

########### install files ###############

install(FILES  timer.h DESTINATION include/timer)

