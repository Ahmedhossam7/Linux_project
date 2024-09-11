cmake_minimum_required(VERSION 3.16)
project(FINAL_PROJECT)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/out/gen)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/out/libs)

add_subdirectory(${CMAKE_SOURCE_DIR}/../Modules/caesar_cipher ${CMAKE_BINARY_DIR}/caesar_cipher)
add_subdirectory(${CMAKE_SOURCE_DIR}/../Modules/xor_cipher ${CMAKE_BINARY_DIR}/xor_cipher)

add_executable(output ${CMAKE_SOURCE_DIR}/app.c)

target_link_libraries(output PRIVATE caesar_cipher xor_cipher)

