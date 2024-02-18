# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(fibonacci_library VERSION 0.0.1 LANGUAGES C)

add_library(fibonacci SHARED
  "fibonacci.c"
)

set_target_properties(fibonacci PROPERTIES
  PUBLIC_HEADER fibonacci.h
  OUTPUT_NAME "fibonacci"
)

target_compile_definitions(fibonacci PUBLIC DART_SHARED_LIB)