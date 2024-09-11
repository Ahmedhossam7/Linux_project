# Paths and files for XOR Cipher
XOR_CIPHER_SRC = $(XOR_CIPHER_DIR)/src/xor_encrypt.c $(XOR_CIPHER_DIR)/src/xor_decrypt.c
XOR_CIPHER_OBJ = $(APP_OBJ_DIR)/xor_encrypt.o $(APP_OBJ_DIR)/xor_decrypt.o
XOR_CIPHER_LIB = $(APP_LIB_DIR)/libxor_cipher.so
XOR_CIPHER_INC = $(XOR_CIPHER_DIR)/inc

# Rules for building the dynamic library
$(XOR_CIPHER_LIB): $(XOR_CIPHER_OBJ)
	echo "Building shared library"
	$(CC) -shared -o $(XOR_CIPHER_LIB) $(XOR_CIPHER_OBJ)

$(APP_OBJ_DIR)/xor_encrypt.o: $(XOR_CIPHER_DIR)/src/xor_encrypt.c  dirs
	$(CC) -fPIC -c -I$(XOR_CIPHER_INC) $(XOR_CIPHER_DIR)/src/xor_encrypt.c -o $(APP_OBJ_DIR)/xor_encrypt.o

$(APP_OBJ_DIR)/xor_decrypt.o: $(XOR_CIPHER_DIR)/src/xor_decrypt.c  dirs
	$(CC) -fPIC -c -I$(XOR_CIPHER_INC) $(XOR_CIPHER_DIR)/src/xor_decrypt.c -o $(APP_OBJ_DIR)/xor_decrypt.o


