all: jetson_gpio gpiod

gpiod: build/gpiod_test

build/gpiod_test: build/main_gpiod.o
	g++ -o build/gpiod_test build/main_gpiod.o $(shell pkg-config --libs gpiodcxx)

build/main_gpiod.o: src_gpiod/main.cpp
	g++ $(shell pkg-config --cflags gpiodcxx) -o build/main_gpiod.o -c src_gpiod/main.cpp 

jetson_gpio: build/jeston_gpio_test

build/jeston_gpio_test: build/main_jetson.o JetsonGPIO/build/libJetsonGPIO.a
	g++ -o build/jeston_gpio_test build/main_jetson.o -LJetsonGPIO/build/ -l:libJetsonGPIO.a -lpthread

build/main_jeston.o: src_jetson_gpio/main.cpp | build JetsonGPIO/include/JetsonGPIOConfig.h
	g++ -o build/main_jetson.o -IJetsonGPIO/include -c src_jetson_gpio/main.cpp

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
