# 本CMakeLists.txt的project名称
# 会自动创建两个变量，PROJECT_SOURCE_DIR和PROJECT_NAME
# ${PROJECT_SOURCE_DIR}：本CMakeLists.txt所在的文件夹路径
# ${PROJECT_NAME}：本CMakeLists.txt的project名称
cmake_minimum_required(VERSION 3.26)
project(Furion)
#set(Furion "CMake_Project")

set(CMAKE_CXX_STANDARD 20)

if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

#include_directories(C:/software/C_library/eigen-3.4.0)

include_directories(C:/software/DEV/vcpkg/packages/gsl_x64-windows/include)
LINK_DIRECTORIES(C:/software/DEV/vcpkg/packages/gsl_x64-windows/lib)
LINK_DIRECTORIES(C:/software/DEV/vcpkg/packages/gsl_x64-windows/bin)

include_directories(C:/software/C_library/fftw-3.3.5)
LINK_DIRECTORIES(C:/software/C_library/fftw-3.3.5)

#include_directories(C:/software/C_library/MPI/Include)
include_directories(${CMAKE_SOURCE_DIR})

#include_directories(C:/software/C_library/boost_1.79.0/include/)
#LINK_DIRECTORIES(C:/software/C_library/boost_1.79.0/lib)




#include_directories(C:/software/C_library/CGAL/CGAL-5.6/include/)
#include_directories(C:/software/C_library/CGAL/CGAL-5.6/auxiliary/gmp/include/)

#LINK_DIRECTORIES(C:/software/C_library/CGAL/CGAL-5.6/auxiliary/gmp/lib)




# include 头文件
#include_directories(C:/Program Files (x86)/Intel/oneAPI/mkl/2023.2.0/include)

#find_package ( MPI )

#message ( STATUS  "MPI_FOUND=${MPI_FOUND}" )
#message ( STATUS  "MPI_CXX_INCLUDE_DIRS=${MPI_CXX_INCLUDE_DIRS}" )
#message ( STATUS  "MPI_LIBRARIES=${MPI_LIBRARIES}" )
#if ( MPI_FOUND )
#	list ( APPEND PRJ_INCLUDE_DIRS ${MPI_CXX_INCLUDE_DIRS} )
#	list ( APPEND PRJ_LIBRARIES ${MPI_LIBRARIES} )
#endif ()


# 定义头文件路径对应的名字
#通用与辅助
set(DISPLAY_H     "${CMAKE_SOURCE_DIR}/src/display")
set(FUR_SCRI_H     "${CMAKE_SOURCE_DIR}/src/furion_scri")
set(IMP_DIS_SRW_H     "${CMAKE_SOURCE_DIR}/src/import_and_display_srw")
set(OPT_ELE_H     "${CMAKE_SOURCE_DIR}/src/optical_element")
set(PROPAGATION_H     "${CMAKE_SOURCE_DIR}/src/propagation")
set(SURFACE_H     "${CMAKE_SOURCE_DIR}/src/surface")
set(XOP_H     "${CMAKE_SOURCE_DIR}/src/xop")
set(SRC_H     "${CMAKE_SOURCE_DIR}/src")

add_subdirectory(${CMAKE_SOURCE_DIR}/src)

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET Furion PROPERTY CXX_STANDARD 20)
endif()

