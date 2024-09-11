CC = gcc
ROOT_DIR = /home/ahmed/Desktop/final_project/project
APP_DIR = $(ROOT_DIR)/Application
MODULES_DIR = $(ROOT_DIR)/Modules

CAESAR_CIPHER_DIR = $(MODULES_DIR)/caesar_cipher
XOR_CIPHER_DIR = $(MODULES_DIR)/xor_cipher

APP_OUT_DIR = $(APP_DIR)
OUT_DIR = $(APP_OUT_DIR)/out
APP_OBJ_DIR = $(OUT_DIR)/gen
APP_LIB_DIR = $(OUT_DIR)/libs
APP_BIN = $(APP_OUT_DIR)/output

APP_SRC = $(APP_OUT_DIR)/app.c
APP_OBJ = $(APP_OBJ_DIR)/app.o

# Include the module Makefiles
include $(MODULES_DIR)/xor_cipher/xor_cipher.mk
include $(MODULES_DIR)/caesar_cipher/caesar_cipher.mk





all: dirs  $(APP_BIN)

$(APP_BIN): $(APP_OBJ) $(CAESAR_CIPHER_LIB) $(XOR_CIPHER_LIB)
	$(CC) $(APP_OBJ) -L$(APP_LIB_DIR) -lcaesar_cipher -lxor_cipher -o $(APP_BIN)

$(APP_OBJ): $(APP_SRC)  | dirs 
	$(CC) -c $(APP_SRC) -I$(CAESAR_CIPHER_DIR)/inc -I$(XOR_CIPHER_DIR)/inc -o $(APP_OBJ)

dirs:
	mkdir -p $(OUT_DIR) $(APP_LIB_DIR) $(APP_OBJ_DIR)

clean:
	rm -rf $(OUT_DIR) $(APP_BIN)

