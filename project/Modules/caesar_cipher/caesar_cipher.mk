# Paths and files for Caesar Cipher
CAESAR_CIPHER_SRC = $(CAESAR_CIPHER_DIR)/src/caesar_encrypt.c $(CAESAR_CIPHER_DIR)/src/caesar_decrypt.c
CAESAR_CIPHER_OBJ = $(APP_OBJ_DIR)/caesar_encrypt.o $(APP_OBJ_DIR)/caesar_decrypt.o
CAESAR_CIPHER_LIB = $(APP_LIB_DIR)/libcaesar_cipher.a
CAESAR_CIPHER_INC = $(CAESAR_CIPHER_DIR)/inc

# Rules for building the static library
$(CAESAR_CIPHER_LIB): $(CAESAR_CIPHER_OBJ)
	echo "Building static lib"
	ar rcs $(CAESAR_CIPHER_LIB) $(CAESAR_CIPHER_OBJ)

$(APP_OBJ_DIR)/caesar_encrypt.o: $(CAESAR_CIPHER_DIR)/src/caesar_encrypt.c  dirs
	$(CC) -c -I$(CAESAR_CIPHER_INC) $(CAESAR_CIPHER_DIR)/src/caesar_encrypt.c -o $(APP_OBJ_DIR)/caesar_encrypt.o

$(APP_OBJ_DIR)/caesar_decrypt.o: $(CAESAR_CIPHER_DIR)/src/caesar_decrypt.c  dirs
	$(CC) -c -I$(CAESAR_CIPHER_INC) $(CAESAR_CIPHER_DIR)/src/caesar_decrypt.c -o $(APP_OBJ_DIR)/caesar_decrypt.o


