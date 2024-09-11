add_library(caesar_cipher STATIC
    src/caesar_encrypt.c
    src/caesar_decrypt.c
)


target_include_directories(caesar_cipher PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/inc)

