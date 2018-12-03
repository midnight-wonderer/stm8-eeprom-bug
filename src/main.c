// Copyright (c) 2018 Sarun Rattanasiri
// under the MIT License https://opensource.org/licenses/MIT

#include "./firmware.h"
#include "button_debounce.h"

const ButtonDebounce_Config button_c3_debounce_config = {
    .fell = &toggle_and_count,
};
static ButtonDebounce_State button_c3_debounce_state;

int main() {
  uint8_t prescaler;

  setup_button();
  setup_led();

  button_debounce__state_init(&button_c3_debounce_state);

#define _PRESCALER_DIVIDE_8 (8 - 1)

  for (prescaler = 0;; prescaler++) {
    // sampling the state of the button
    if (!(prescaler & _PRESCALER_DIVIDE_8)) {
      button_debounce__sample(&button_c3_debounce_config,
                              &button_c3_debounce_state, sample_button());
    }
  }
}
