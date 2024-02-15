# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(cJSON_library VERSION 0.0.1 LANGUAGES C)

add_library(cJSON SHARED
  "cJSON.c"
)

set_target_properties(cJSON PROPERTIES
  PUBLIC_HEADER cJSON.h
  OUTPUT_NAME "cJSON"
)

target_compile_definitions(cJSON PUBLIC DART_SHARED_LIB)