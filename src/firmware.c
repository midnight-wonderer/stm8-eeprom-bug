#define STM8S103
#include "./firmware.h"
#include "stm8s.h"
#include "stm8s_flash.h"

typedef struct EEPROM_struct {
  __IO uint8_t counting_value;
} EEPROM_TypeDef;

#define EEPROM ((EEPROM_TypeDef*)FLASH_DATA_START_PHYSICAL_ADDRESS)

void setup_button() {
  SetBit(GPIOC->CR1, 3);
}

void setup_led() {
  SetBit(GPIOB->DDR, 5);
  SetBit(GPIOB->ODR, 5);
}

uint8_t sample_button() {
  return ValBit(GPIOC->IDR, 3);
}

uint8_t count = 0;
void toggle_and_count() {
  // toggle
  ChgBit(GPIOB->ODR, 5);

  // count
  count++;
  while (!(FLASH->IAPSR & FLASH_IAPSR_DUL)) {
    FLASH->DUKR = FLASH_RASS_KEY1;
    FLASH->DUKR = FLASH_RASS_KEY2;
  }
  EEPROM->counting_value = count;
  FLASH->IAPSR &= ~FLASH_IAPSR_DUL;
}
