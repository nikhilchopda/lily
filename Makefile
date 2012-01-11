CC=gcc
CFLAGS=-c -g3 -Wall

BINDIR=bin
OBJDIR=objdir

# todo: Look into making this autogenerated, instead of pretending that the deps
#       are correct.
CORE_OBJECTS=$(OBJDIR)/lily_parser.o \
			$(OBJDIR)/lily_lexer.o \
			$(OBJDIR)/lily_ast.o \
			$(OBJDIR)/lily_emitter.o \
			$(OBJDIR)/lily_symtab.o \
			$(OBJDIR)/lily_vm.o \
			$(OBJDIR)/lily_interp.o \
			$(OBJDIR)/lily_debug.o \
			$(OBJDIR)/lily_error.o

FS_OBJECTS=$(CORE_OBJECTS) \
			$(OBJDIR)/fs_main.o

TESTER_OBJECTS=$(CORE_OBJECTS) \
				$(OBJDIR)/tester_main.o

all: lily_fs lily_tester

clean:
	rm -f $(OBJDIR)/* lily_fs lily_tester

lily_tester: $(TESTER_OBJECTS)
	$(CC) $(TESTER_OBJECTS) -o lily_tester

lily_fs: $(FS_OBJECTS)
	$(CC) $(FS_OBJECTS) -o lily_fs

# Becomes an executable
$(OBJDIR)/fs_main.o: fs_main.c lily_lexer.h lily_parser.h lily_emitter.h \
					 lily_symtab.h
	$(CC) $(CFLAGS) fs_main.c -o $(OBJDIR)/fs_main.o

$(OBJDIR)/tester_main.o: tester_main.c lily_interp.h
	$(CC) $(CFLAGS) tester_main.c -o $(OBJDIR)/tester_main.o

# Core
$(OBJDIR)/lily_lexer.o: lily_lexer.c lily_lexer.h lily_impl.h
	$(CC) $(CFLAGS) lily_lexer.c -o $(OBJDIR)/lily_lexer.o

$(OBJDIR)/lily_parser.o: lily_parser.c lily_lexer.h lily_impl.h lily_symtab.h \
						 lily_ast.h lily_vm.h lily_expr_op.h
	$(CC) $(CFLAGS) lily_parser.c -o $(OBJDIR)/lily_parser.o

$(OBJDIR)/lily_ast.o: lily_ast.c lily_ast.h lily_symtab.h lily_impl.h \
					  lily_expr_op.h
	$(CC) $(CFLAGS) lily_ast.c -o $(OBJDIR)/lily_ast.o

$(OBJDIR)/lily_emitter.o: lily_emitter.c lily_opcode.h lily_impl.h \
						  lily_emit_table.h
	$(CC) $(CFLAGS) lily_emitter.c -o $(OBJDIR)/lily_emitter.o

$(OBJDIR)/lily_symtab.o: lily_symtab.c lily_symtab.h lily_builtins.h \
						 lily_seed_symtab.h
	$(CC) $(CFLAGS) lily_symtab.c -o $(OBJDIR)/lily_symtab.o

$(OBJDIR)/lily_vm.o: lily_vm.c lily_vm.h
	$(CC) $(CFLAGS) lily_vm.c -o $(OBJDIR)/lily_vm.o

$(OBJDIR)/lily_interp.o: lily_interp.c lily_interp.h
	$(CC) $(CFLAGS) lily_interp.c -o $(OBJDIR)/lily_interp.o

$(OBJDIR)/lily_debug.o: lily_debug.c lily_debug.h
	$(CC) $(CFLAGS) lily_debug.c -o $(OBJDIR)/lily_debug.o

$(OBJDIR)/lily_error.o: lily_error.c lily_error.h
	$(CC) $(CFLAGS) lily_error.c -o $(OBJDIR)/lily_error.o

.PHONY: clean all
