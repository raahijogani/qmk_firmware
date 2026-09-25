CONVERT_TO = sparkfun_pm2040
# The KLOR pinout is Pro Micro-compatible; this selects the RP2040 converter.
PIN_COMPATIBLE = promicro
QUANTUM_PAINTER = yes
QUANTUM_PAINTER_DRIVERS += sh1106_i2c

# Per-key WS2812 RGB matrix (the KLOR LEDs use data pin D3).
RGB_MATRIX_ENABLE = yes
