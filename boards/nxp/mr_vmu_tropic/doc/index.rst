.. zephyr:board:: vmu_tropic

Overview
********

The VMU Tropic features an i.MX RT1064 single core MCU with the
Cortex-M7 core at 600 MHz.
The i.MX RT1064 MCU offers support over a wide temperature range
and is qualified for consumer, industrial and automotive markets.
The VMU Tropic is a compact Vehicle Management Unit designed by NXP's
Mobile Robotics Group for use with CogniPilot's Cerebri, a
Zephyr RTOS based Autopilot.

Hardware
********

- MIMXRT1064DVJ6B MCU

  - 600 MHz Cortex-M7
  - 4MB on-chip Flash
  - 1MB SRAM

- Memory

  - SD card socket (USDHC1)

- Ethernet

  - 100BASE-T1 single-pair Ethernet (TJA1103)

- USB

  - USB Type-C connector (USB OTG)

- Power

  - USB Type-C power input with NX5P3363 USB power switch
  - 3.3V regulated supply (TLV75733)
  - 1.8V regulated supply (NCP151)
  - RTC battery backup solder pads

- Debug

  - SWD debug interface (SWDIO, SWDCLK, SWO)
  - Console UART (CONSOLE_TX / CONSOLE_RX)

- Sensor

  - BMI088 6-axis IMU (Accelerometer + Gyroscope)
  - BMP390 Barometric Pressure Sensor
  - BMM350 Magnetometer
  - ICM-45686 6-axis IMU

- CAN

- UART JST-GH connectors

  - TELEM1, TELEM2, AUX, GPS, Console, RC-ELRS

- I2C JST-GH connectors

  - External I2C (EXT_SCL / EXT_SDA)

- PWM outputs

  - 8x PWM outputs (PWM_1 – PWM_8) via JST-SH connectors

- OSD SPI interface

- RGB LED


For more information about the MIMXRT1064 SoC and VMU Tropic board, see
these references:

- `VMU Tropic Schematics`_
- `i.MX RT1064 Datasheet`_
- `i.MX RT1064 Reference Manual`_

Supported Features
==================

VMU-Tropic is a "Vehicle Management Unit" based on the i.MX RT1064
processor.

.. zephyr:board-supported-hw::

Connections and I/Os
====================

The MIMXRT1064 SoC has five groups of pinmux/gpio controllers.

+-------------------+-----------------------------+----------------------------+
| Name              | Function                    | Usage                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_02       | FLEXPWM4_PWM1_A             | PWM_5                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_03       | FLEXPWM4_PWM1_B             | PWM_6                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_04       | FLEXPWM4_PWM2_A             | PWM_7                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_05       | FLEXPWM4_PWM2_B             | PWM_8                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_06       | FLEXPWM2_PWM0_A             | PWM_1                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_07       | FLEXPWM2_PWM0_B             | PWM_2                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_08       | FLEXPWM2_PWM1_A             | PWM_3                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_09       | FLEXPWM2_PWM1_B             | PWM_4                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_21       | GPIO4_IO21                  | PM_SDA                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_22       | GPIO4_IO22                  | PM_SCL                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_23       | GPIO4_IO23                  | BUZZER                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_25       | LPUART6_TXD                 | CONSOLE_TX                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_26       | LPUART6_RXD                 | CONSOLE_RX                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_27       | LPUART5_RTS_B               | TELEM2_RTS                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_28       | LPUART5_CTS_B               | TELEM2_CTS                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_29       | GPIO4_IO29                  | BMM350_INT                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_30       | GPIO4_IO30                  | BMP390_INT                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_31       | GPIO4_IO31                  | ONE_WIRE                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_32       | GPIO3_IO18                  | ICM-45686_DRDY             |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_33       | GPIO3_IO19                  | LED_RED                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_34       | GPIO3_IO20                  | LED_BLUE                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_35       | GPIO3_IO21                  | USDHC1_CD                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_36       | FLEXCAN3_TX                 | CAN3_TX                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_37       | FLEXCAN3_RX                 | CAN3_RX                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_38       | GPIO3_IO24                  | LED_GREEN                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_EMC_39       | GPIO3_IO25                  | GPS_LED                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_04     | GPIO1_IO04                  | BOOT_MODE_BUTTON           |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_06     | GPIO1_IO06                  | SWDIO                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_07     | GPIO1_IO07                  | SWDCLK                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_12     | LPI2C4_SCL                  | BARO_MAG_SCL               |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_13     | LPI2C4_SDA                  | BARO_MAG_SDA               |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_14     | GPIO1_IO14                  | AUX_RTS                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B0_15     | GPIO1_IO15                  | AUX_CTS                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_00     | LPI2C1_SCL                  | EXT_SCL                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_01     | LPI2C1_SDA                  | EXT_SDA                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_02     | GPIO1_IO18                  | GPS_TX                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_03     | GPIO1_IO19                  | GPS_RX                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_04     | LPUART3_CTS_B               | TELEM_CTS                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_05     | LPUART3_RTS_B               | TELEM_RTS                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_06     | LPUART3_TXD                 | TELEM_TX                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_07     | LPUART3_RXD                 | TELEM_RX                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_08     | ADC1_IN14                   | ADC_5V                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_09     | GPIO1_IO14                  | BMI088_DRDY1               |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_10     | LPUART8_TXD                 | RC_TX                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_11     | LPUART8_RXD                 | RC_RX                      |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_12     | LPSPI3_PCS0                 | SPI2_CS                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_13     | LPSPI3_SIN                  | SPI2_MISO                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_14     | LPSPI3_SOUT                 | SPI2_MOSI                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_AD_B1_15     | LPSPI3_SCK                  | SPI2_SCK                   |
+-------------------+-----------------------------+----------------------------+

| GPIO_B0_00        | LPSPI4_PCS0                 | SPI1_CS                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_01        | LPSPI4_SIN                  | SPI1_MISO                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_02        | LPSPI4_SOUT                 | SPI1_MOSI                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_03        | LPSPI4_SCK                  | SPI1_SCK                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_10        | GPIO2_IO10                  | BMI088_DRDY2               |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_12        | GPIO1_IO12                  | ARM                        |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_13        | GPIO1_IO13                  | SWO                        |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_14        | ENET2_TX_EN                 | ETH_RST                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_B0_15        | ENET2_TX_CLK2               | ETH_INT                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_00        | GPIO2_IO16                  | AUX_TX                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_01        | GPIO2_IO17                  | AUX_RX                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_02        | LPSPI4_PCS2                 | SPI1_CS2                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_04        | ENET_RX_DATA0               | ETH_RXD0                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_05        | ENET_RX_DATA1               | ETH_RXD1                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_06        | ENET_RX_EN                  | ETH_DV                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_07        | ENET_TX_DATA0               | ETH_TXD0                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_08        | ENET_TX_DATA1               | ETH_TXD1                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_09        | ENET_TX_EN                  | ETH_TX_EN                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_10        | ENET_REF_CLK                | ENET_RMII_REF_CLK          |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_11        | ENET_RX_ER                  | ETH_RX_ER                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_12        | ENET_1588_EVENT0_IN         | TELEM2_TX                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_13        | ENET_1588_EVENT0_OUT        | TELEM2_RX                  |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_14        | ENET_MDC                    | ETH_MDC                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_B1_15        | ENET_MDIO                   | ETH_MDIO                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_00     | USDHC1_CMD                  | USDHC1_CMD                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_01     | USDHC1_CLK                  | USDHC1_CLK                 |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_02     | USDHC1_DATA0                | USDHC1_DAT0                |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_03     | USDHC1_DATA1                | USDHC1_DAT1                |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_04     | USDHC1_DATA2                | USDHC1_DATA2               |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B0_05     | USDHC1_DATA3                | USDHC1_DATA3               |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_06     | LPSPI2_PCS0                 | OSD_CS                     |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_07     | LPSPI2_SCK                  | OSD_SCK                    |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_08     | LPSPI2_SOUT                 | OSD_MOSI                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_09     | LPSPI2_SIN                  | OSD_MISO                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_10     | LPSPI2_PCS2                 | OSD_DRDY                   |
+-------------------+-----------------------------+----------------------------+
| GPIO_SD_B1_11     | LPSPI2_PCS3                 | OSD_nRESET                 |
+-------------------+-----------------------------+----------------------------+
| USB_DN            | USB_OTG1_DN                 | USB_DN                     |
+-------------------+-----------------------------+----------------------------+
| USB_DP            | USB_OTG1_DP                 | USB_DP                     |
+-------------------+-----------------------------+----------------------------+
| USB_VBUS          | USB_OTG1_VBUS               | VBUS                       |
+-------------------+-----------------------------+----------------------------+

Serial Port
===========

The MIMXRT1064 SoC has 8 UARTs.

Programming and Debugging
*************************

.. zephyr:board-supported-runners::

Build and flash applications as usual (see :ref:`build_an_application` and
:ref:`application_run` for more details).

Configuring a Debug Probe
=========================

A debug probe is used for both flashing and debugging the board.

Using J-Link
------------

Install the :ref:`jlink-debug-host-tools` and make sure they are in your search
path.

Connect the J-Link debugger to the SWD header (SWDIO, SWDCLK, SWO, GND).

Configuring a Console
=====================

Connect to the CONSOLE UART (LPUART1) via the debug connector with the
following settings:

- Speed: 115200
- Data: 8 bits
- Parity: None
- Stop bits: 1

Flashing
========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: vmu_tropic
   :goals: flash

You should see the following message in the terminal:

.. code-block:: console

   ***** Booting Zephyr OS v3.4.0-xxxx-xxxxxxxxxxxxx *****
   Hello World! vmu_tropic

Debugging
=========

Here is an example for the :zephyr:code-sample:`hello_world` application.

.. zephyr-app-commands::
   :zephyr-app: samples/hello_world
   :board: vmu_tropic
   :goals: debug

Open a serial terminal, step through the application in your debugger, and you
should see the following message in the terminal:

.. code-block:: console

   ***** Booting Zephyr OS v4.4.x-xxxx-xxxxxxxxxxxxx *****
   Hello World! vmu_tropic

.. include:: ../../common/board-footer.rst.inc

.. _i.MX RT1064 Datasheet:
   https://www.nxp.com/docs/en/data-sheet/IMXRT1064CEC.pdf

.. _i.MX RT1064 Reference Manual:
   https://www.nxp.com/webapp/Download?colCode=IMXRT1064RM