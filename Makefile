all: build/gpio_test

build/gpio_test: build/main.o JetsonGPIO/build/libJetsonGPIO.so.1.2.5
	g++ -LJetsonGPIO/build/ -lJetsonGPIO -lpthread -o build/gpio_test build/main.o

build/main.o: src/main.cpp | build
	g++ -o build/main.o -IJetsonGPIO/include -c src/main.cpp

JetsonGPIO/build/libJetsonGPIO.so.1.2.5: 
	cmake -S JetsonGPIO -B JetsonGPIO/build
	cmake --build JetsonGPIO/build

build:
	mkdir build

clean:
	rm -r build JetsonGPIO/build
