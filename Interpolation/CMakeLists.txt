
cmake_minimum_required(VERSION 3.10)

# 프로젝트 이름과 사용 언어 설정
project(Interpolation LANGUAGES CXX)

set(FirstOpenGInterpolationL_ROOT "${PROJECT_SOURCE_DIR}")

# Set build output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build)


# Turn on folder usage
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

# C++ 표준 설정
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# find_package를 사용하여 OpenGL 및 GLUT 라이브러리 찾기
find_package(GLUT REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
find_package(DevIL REQUIRED)
find_package(GLM REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/Slerp)

# FirstOpenGL *.cpp 추가
file(GLOB Slerp_CPP
    "Slerp/*.cpp"
    "Slerp/*.h"
)

# preprocess define
add_compile_definitions(GLM_ENABLE_EXPERIMENTAL)

add_executable(Slerp ${Slerp_CPP})
target_link_libraries(Slerp GLEW::GLEW)
target_link_libraries(Slerp GLUT::GLUT)