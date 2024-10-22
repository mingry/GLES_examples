
cmake_minimum_required(VERSION 3.10)

# 프로젝트 이름과 사용 언어 설정
project(CarGame LANGUAGES CXX)

set(CarGame_ROOT "${PROJECT_SOURCE_DIR}")

# Set build output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build)


# Turn on folder usage
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

# C++ 표준 설정
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# find_package를 사용하여 OpenGL 및 GLUT 라이브러리 찾기
find_package(GLUT REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
find_package(DevIL REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/BaseCodes)
include_directories(${PROJECT_SOURCE_DIR}/Include)
include_directories(${PROJECT_SOURCE_DIR}/CarGame0)

# BaseCodes  *.cpp 추가
file(GLOB_RECURSE BaseCodes_CPP
    "BaseCodes/*.cpp"
    "BaseCodes/*.h"
)

# all in CarGame0 folder
file(GLOB_RECURSE CarGame0_SRC
    "CarGame0/*.cpp"
    "CarGame0/*.h"
)

file(GLOB CarGamePBR_SRC
    "CarGamePBR/*.cpp"
    "CarGamePBR/*.h"
)

file(GLOB_RECURSE CarGameGooch_SRC
    "CarGameGooch/*.cpp"
    "CarGameGooch/*.h"  
)

file(GLOB CarGamePostPro_SRC
    "CarGamePostPro/*.cpp"
    "CarGamePostPro/*.h"
)

file(GLOB_RECURSE CarGameTexture_SRC
    "CarGameTexture/*.cpp"
    "CarGameTexture/*.h"
)

file(GLOB_RECURSE CarGameLSystem_SRC
    "CarGameLSystem/*.cpp"
    "CarGameLSystem/*.h"
)

file(GLOB_RECURSE CarGameDoF_SRC
    "CarGameDoF/*.cpp"
    "CarGameDoF/*.h"
)

# preprocess define
add_compile_definitions(GLM_ENABLE_EXPERIMENTAL)

# 실행 파일 생성
add_executable(CarGame0 ${CarGame0_SRC} ${BaseCodes_CPP})
# target_link_libraries(CarGame0 ${GLUT_LIBRARY})
target_link_libraries(CarGame0 GLUT::GLUT)
target_link_libraries(CarGame0 OpenGL::GL)
target_link_libraries(CarGame0 GLEW::GLEW)

add_executable(CarGamePBR ${CarGamePBR_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGamePBR GLUT::GLUT)
target_link_libraries(CarGamePBR OpenGL::GL)
target_link_libraries(CarGamePBR GLEW::GLEW)

# 실행 파일 생성
add_executable(CarGameGooch ${CarGameGooch_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGameGooch GLUT::GLUT)
target_link_libraries(CarGameGooch OpenGL::GL)
target_link_libraries(CarGameGooch GLEW::GLEW)

add_executable(CarGamePostPro ${CarGamePostPro_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGamePostPro GLUT::GLUT)
target_link_libraries(CarGamePostPro OpenGL::GL)
target_link_libraries(CarGamePostPro GLEW::GLEW)
target_link_libraries(CarGamePostPro DevIL::IL DevIL::ILU)


# 실행 파일 생성
add_executable(CarGameTexture ${CarGameTexture_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGameTexture GLUT::GLUT)
target_link_libraries(CarGameTexture OpenGL::GL)
target_link_libraries(CarGameTexture GLEW::GLEW)
target_link_libraries(CarGameTexture DevIL::IL DevIL::ILU)


add_executable(CarGameLSystem ${CarGameLSystem_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGameLSystem GLUT::GLUT)
target_link_libraries(CarGameLSystem OpenGL::GL)
target_link_libraries(CarGameLSystem GLEW::GLEW)
target_link_libraries(CarGameLSystem DevIL::IL DevIL::ILU)

add_executable(CarGameDoF ${CarGameDoF_SRC} ${BaseCodes_CPP})
target_link_libraries(CarGameDoF GLUT::GLUT)
target_link_libraries(CarGameDoF OpenGL::GL)
target_link_libraries(CarGameDoF GLEW::GLEW)
target_link_libraries(CarGameDoF DevIL::IL DevIL::ILU)