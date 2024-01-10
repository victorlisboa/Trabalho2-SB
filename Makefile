AS = nasm
AFLAGS = -f elf -g -Fdwarf
LN = ld
LFLAGS = -m elf_i386

SRC_DIR = .
OBJ_DIR = obj
BIN_DIR = .

SRC_FILES = $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRC_FILES))
PERMANENT_OBJS = $(addprefix $(OBJ_DIR)/, soma.o subtracao.o multiplicacao.o divisao.o mod.o exponenciacao.o io.o)

PROGRAMS = calc16 calc32

.PHONY: all
all: setup $(PROGRAMS)

.PHONY: setup
setup:
	mkdir -p $(BIN_DIR) $(OBJ_DIR)

calc16: $(OBJ_DIR)/main16.o $(PERMANENT_OBJS)
	$(LN) $(LFLAGS) $^ -o $(BIN_DIR)/$@

calc32: $ $(OBJ_DIR)/main32.o $(PERMANENT_OBJS)
	$(LN) $(LFLAGS) $^ -o $(BIN_DIR)/$@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(AS) $(AFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf $(OBJ_DIR)/*.o $(addprefix $(BIN_DIR)/,$(PROGRAMS))
