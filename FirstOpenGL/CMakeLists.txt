cmake_minimum_required(VERSION 3.10)

# 프로젝트 이름과 사용 언어 설정
project(FirstOpenGL LANGUAGES CXX)

set(FirstOpenGL_ROOT "${PROJECT_SOURCE_DIR}")

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

include_directories(${PROJECT_SOURCE_DIR}/FirstOpenGL)

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

add_executable(FirstOpenGL FirstOpenGL/main_FirstOpenGL.cpp)
target_link_libraries(FirstOpenGL GLEW::GLEW)
target_link_libraries(FirstOpenGL GLUT::GLUT)
target_link_libraries(FirstOpenGL DevIL::IL DevIL::ILU)

add_executable(FirstOpenGL_FShader FirstOpenGL_FShader/main_FirstOpenGL_FShader.cpp)
target_link_libraries(FirstOpenGL_FShader GLUT::GLUT)
target_link_libraries(FirstOpenGL_FShader OpenGL::GL)
target_link_libraries(FirstOpenGL_FShader GLEW::GLEW)

add_executable(RotatingCube0 RotatingCube0/main_RotatingCube0.cpp)
target_link_libraries(RotatingCube0 GLUT::GLUT)
target_link_libraries(RotatingCube0 OpenGL::GL)
target_link_libraries(RotatingCube0 GLEW::GLEW)

add_executable(RotatingCube1 RotatingCube1/main_RotatingCube1.cpp)
target_link_libraries(RotatingCube1 GLUT::GLUT)
target_link_libraries(RotatingCube1 OpenGL::GL)
target_link_libraries(RotatingCube1 GLEW::GLEW)

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
