all: build/gpio_test

build/gpio_test: build/main.o JetsonGPIO/build/libJetsonGPIO.a
	g++ -o build/gpio_test build/main.o -LJetsonGPIO/build/ -l:libJetsonGPIO.a -lpthread

build/main.o: src/main.cpp | build JetsonGPIO/include/JetsonGPIOConfig.h
	g++ -o build/main.o -IJetsonGPIO/include -c src/main.cpp

JetsonGPIO: JetsonGPIO/build/libJetsonGPIO.a JetsonGPIO/include/JetsonGPIOConfig.h

JetsonGPIO/include/JetsonGPIOConfig.h: JetsonGPIO/build/libJetsonGPIO.a 
	cp JetsonGPIO/build/JetsonGPIOConfig.h JetsonGPIO/include/JetsonGPIOConfig.h

JetsonGPIO/build/libJetsonGPIO.a: 
	cmake -S JetsonGPIO -B JetsonGPIO/build
	cmake --build JetsonGPIO/build


build:
	mkdir -p build

clean:
	rm -r build JetsonGPIO/build
