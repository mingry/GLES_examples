
cmake_minimum_required(VERSION 3.10)

# 프로젝트 이름과 사용 언어 설정
project(FirstOpenGL LANGUAGES CXX)

set(FirstOpenGL_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/FirstOpenGL")

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

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/FirstOpenGL)

# FirstOpenGL *.cpp 추가
file(GLOB FirstOpenGL_CPP
    "FirstOpenGL/*.cpp"
    "FirstOpenGL/*.h"
)

# FirstOpenGL_FShader *.cpp 추가
file(GLOB FirstOpenGL_FShader_SRC
    "FirstOpenGL_FShader/*.cpp"
    "FirstOpenGL_FShader/*.h"
)

# RotatingCube2 *.cpp 추가
file(GLOB RotatingCube2_SRC
    "RotatingCube2/*.cpp"
    "RotatingCube2/*.h"
)

# RotatingCube3 *.cpp 추가
file(GLOB RotatingCube3_SRC
    "RotatingCube3/*.cpp"
    "RotatingCube3/*.h"
)

# RotatingCyinder *.cpp 추가
file(GLOB RotatingCylinder_SRC
    "RotatingCylinder/*.cpp"
    "RotatingCylinder/*.h"
)

# preprocess define
add_compile_definitions(GLM_ENABLE_EXPERIMENTAL)

add_executable(FirstOpenGL ${FirstOpenGL_CPP})
target_link_libraries(FirstOpenGL GLUT::GLUT)
target_link_libraries(FirstOpenGL OpenGL::GL)
target_link_libraries(FirstOpenGL GLEW::GLEW)
target_link_libraries(FirstOpenGL DevIL::IL DevIL::ILU)

add_executable(FirstOpenGL_FShader ${FirstOpenGL_FShader_SRC})
target_link_libraries(FirstOpenGL_FShader GLUT::GLUT)
target_link_libraries(FirstOpenGL_FShader OpenGL::GL)
target_link_libraries(FirstOpenGL_FShader GLEW::GLEW)

add_executable(RotatingCube RotatingCube/main_RotatingCube.cpp)
target_link_libraries(RotatingCube GLUT::GLUT)
target_link_libraries(RotatingCube OpenGL::GL)
target_link_libraries(RotatingCube GLEW::GLEW)

add_executable(RotatingCube2 ${RotatingCube2_SRC})
target_link_libraries(RotatingCube2 GLUT::GLUT)
target_link_libraries(RotatingCube2 OpenGL::GL)
target_link_libraries(RotatingCube2 GLEW::GLEW)

add_executable(RotatingCube3 ${RotatingCube3_SRC})
target_link_libraries(RotatingCube3 GLUT::GLUT)
target_link_libraries(RotatingCube3 OpenGL::GL)
target_link_libraries(RotatingCube3 GLEW::GLEW) 

add_executable(RotatingCylinder ${RotatingCylinder_SRC})
target_link_libraries(RotatingCylinder GLUT::GLUT)
target_link_libraries(RotatingCylinder OpenGL::GL)
target_link_libraries(RotatingCylinder GLEW::GLEW)
