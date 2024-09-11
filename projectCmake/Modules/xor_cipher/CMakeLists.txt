add_library(xor_cipher SHARED
	src/xor_encrypt.c
	src/xor_decrypt.c
	)
	
target_include_directories(xor_cipher PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/inc)
