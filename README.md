# gpio_test
testing gpio for the jetson nano

## Installing the library

If for some reason you need to install the library (as of writing this it is installed on the board) do the following

```
wget http://mirrors.edge.kernel.org/pub/software/libs/libgpiod/libgpiod-2.2.tar.xz
tar -xf libgpiod-2.2.tar.xz 
cd libgpiod-2.2
./configure --enable-bindings-cxx
make
sudo make install
```
