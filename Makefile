CFLAGS := -std=c++17 $(shell pkg-config --cflags libgpiodcxx)
LDFLAGS := $(shell pkg-config --libs libgpiodcxx)
all: build/gpiod_test

build/gpiod_test: build/main.o
	g++ -o build/gpiod_test build/main.o $(LDFLAGS) 

build/main.o: src/main.cpp | build
	g++ $(CFLAGS) -o build/main.o -c src/main.cpp 

build:
	mkdir -p build

clean:
	rm -r build

