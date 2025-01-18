# Nazwa pliku wykonywalnego
# so Simple it's Offensive SHell
TARGET = sosh

# Kompilator
CC = gcc

# Flagi kompilatora
CFLAGS = -Wall -Wextra -g
RELEASE_FLAGS = -O2

# Źródła i obiekty
SRCDIR = src
OBJDIR = obj
SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))

# Reguła domyślna
all: $(TARGET)

# Reguła budowania pliku wykonywalnego
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

# Reguła kompilacji plików .c do .o w katalogu obj/
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Tworzenie katalogu obj/, jeśli nie istnieje
$(OBJDIR):
	mkdir -p $@

debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(TARGET)

release: CFLAGS += $(RELEASE_FLAGS)
release: $(TARGET)

# Czyszczenie plików tymczasowych
clean:
	rm -f $(TARGET) $(OBJECTS)

# Phony targets (niezależne od plików o tych nazwach)
.PHONY: all clean

