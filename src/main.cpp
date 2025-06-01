// SPDX-License-Identifier: GPL-2.0-or-later
// SPDX-FileCopyrightText: 2023 Kent Gibson <warthog618@gmail.com>

/* Minimal example of toggling a single line. */

#include <chrono>
#include <cstdlib>
#include <filesystem>
#include <gpiod.hpp>
#include <iostream>
#include <thread>

const std::filesystem::path chip_path("/dev/gpiochip0");
const gpiod::line::offset line_offset = 5; // TODO: set this to pin 40 or PI.00

int main() {
  auto blink_request =
      gpiod::chip(chip_path) // Open the chip
          .prepare_request() // Create a line request
          .set_consumer("Blink LED") // Set the consumer name for debugging
          // We add line settings, making this an output pin
          .add_line_settings(line_offset, gpiod::line_settings().set_direction(
                                              gpiod::line::direction::OUTPUT)) 
          // Finalize the setup request
          .do_request();

  for (;;) {


    blink_request.set_value(line_offset, gpiod::line::value::ACTIVE);
    std::cout << line_offset << " is on \n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    blink_request.set_value(line_offset, gpiod::line::value::INACTIVE);
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << line_offset << " is off \n";
  }
}
