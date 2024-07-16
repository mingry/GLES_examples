
cmake_minimum_required(VERSION 3.10)

# 프로젝트 이름과 사용 언어 설정
project(LightingExamples_ROOT LANGUAGES CXX)

set(LightingExamples_ROOT "${PROJECT_SOURCE_DIR}")

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

include_directories(${PROJECT_SOURCE_DIR}/BaseCodes)

# BaseCodes  *.cpp 추가
file(GLOB_RECURSE BaseCodes_CPP
    "BaseCodes/*.cpp"
    "BaseCodes/*.h"
)

file(GLOB DirectionalLightExample_CPP
    "DirectionalLightExample/*.cpp"
    "DirectionalLightExample/*.h"
)

file(GLOB MultiLightsExample_CPP
    "MultiLightsExample/*.cpp"
    "MultiLightsExample/*.h"
)

file(GLOB PointLightExample_CPP
    "PointLightExample/*.cpp"
    "PointLightExample/*.h"
)

file(GLOB SpotLightExample_CPP
    "SpotLightExample/*.cpp"
    "SpotLightExample/*.h"
)


# preprocess define
add_compile_definitions(GLM_ENABLE_EXPERIMENTAL)

# 실행 파일 생성
add_executable(DirectionalLightExample ${DirectionalLightExample_CPP} ${BaseCodes_CPP})
target_link_libraries(DirectionalLightExample GLEW::GLEW)
target_link_libraries(DirectionalLightExample GLUT::GLUT)
target_link_libraries(DirectionalLightExample OpenGL::GL)

add_executable(MultiLightsExample ${MultiLightsExample_CPP} ${BaseCodes_CPP})
target_link_libraries(MultiLightsExample GLEW::GLEW)
target_link_libraries(MultiLightsExample GLUT::GLUT)
target_link_libraries(MultiLightsExample OpenGL::GL)

add_executable(PointLightExample ${PointLightExample_CPP} ${BaseCodes_CPP})
target_link_libraries(PointLightExample GLEW::GLEW)
target_link_libraries(PointLightExample GLUT::GLUT)
target_link_libraries(PointLightExample OpenGL::GL)

add_executable(SpotLightExample ${SpotLightExample_CPP} ${BaseCodes_CPP})
target_link_libraries(SpotLightExample GLEW::GLEW)
target_link_libraries(SpotLightExample GLUT::GLUT)
target_link_libraries(SpotLightExample OpenGL::GL)


