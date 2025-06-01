// SPDX-License-Identifier: GPL-2.0-or-later
// SPDX-FileCopyrightText: 2023 Kent Gibson <warthog618@gmail.com>

/* Minimal example of toggling a single line. */

#include <chrono>
#include <cstdlib>
#include <string>
#include <gpiod.hpp>
#include <iostream>
#include <thread>

const std::string chip_path = "/dev/gpiochip0" ;
const int line_offset = 41; // Pin 32
int main() {
  gpiod::chip chip(chip_path);
  auto led = chip.get_line(line_offset);
  led.request({"Blink", gpiod::line_request::DIRECTION_OUTPUT, 0});
  for (;;) {
    led.set_value(1);
    std::cout << line_offset << " is on \n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    led.set_value(0);
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << line_offset << " is off \n";
  }
}
