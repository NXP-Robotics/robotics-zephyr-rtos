.. _mr_mcxn_t1:

MR-MCXN-T1 (NXP MCXN947 Base Board)
###################################

Overview
********

The **MR-MCXN-T1** is the NXP MCXN947-based base board of the CogniPilot /
Mobile Robotics platform. It provides the compute core and all on-board
peripherals, plus a **board-to-board expansion connector** that accepts
application-specific add-on boards (Zephyr *shields*):

* :ref:`mr_mcxn_t1_oflo` -- optical-flow / ToF sensing shield
* :ref:`mr_mcxn_t1_f9p` -- u-blox NEO-F9P GNSS/RTK shield

Base-board features:

* NXP **MCXN947** dual-core Arm Cortex-M33 (part ``MCXN947VDFT``), 2 MB flash, 512 KB RAM
* 3S-12S supply input
* **100BASE-T1** single-pair Ethernet (NXP TJA1103 PHY)
* **2x CAN FD** (NXP TJA1462 transceivers)
* On-board **IMU** (TDK ICM-45686)
* On-board **magnetometer** (Bosch BMM350) and **barometer** (Bosch BMP581)
* **USB** Type-C (device / CDC-ACM console)
* **10-pin Pixhawk-standard debug connector** (SWD + console UART)
* Addressable **RGB LED** (APA102-class, driven via FlexIO SPI)

Zephyr Board Target
*******************

.. list-table::
   :widths: 30 70

   * - Board identifier
     - ``mr_mcxn_t1/mcxn947/cpu0``
   * - Full name
     - NXP X-MR-MCXN-T1 MCXN947 (CPU0)
   * - SoC / cluster
     - ``nxp,mcxn947`` (compatible ``nxp,mcx``), Cortex-M33 cpu0
   * - RAM / Flash (metadata)
     - 320 KB / 2048 KB
   * - Kernel timer
     - SysTick (``&os_timer`` disabled, ``&systick`` enabled)
   * - Security
     - TrustZone-M secure (``CONFIG_TRUSTED_EXECUTION_SECURE=y``), ARM MPU enabled

.. warning::

   Because of an I3C performance /
   startup lock-up issue on the BMM350, the default board configuration does **not** use I3C0. Instead it:

   * disables ``&i3c0`` and the ``&flexcomm1_lpuart1`` console;
   * re-purposes the FlexComm 1 pins (``P0_20``/``P0_21``) as **LPI2C1** and
     attaches the **BMM350** at I2C address ``0x14`` (400 kHz);
   * **removes** the ``bmp581_0`` node (barometer not enabled in this config);
   * moves the console / shell / mcumgr to **USB CDC-ACM**
     (``snippet_cdc_acm_console_uart`` on ``usb1``).

   The nominal (non-workaround) intent is I3C0 for both BMM350 and BMP581, with
   the console on LPUART1. Both are documented below; the workaround config is
   what actually ships today.

On-board Peripherals
********************

.. list-table::
   :header-rows: 1
   :widths: 18 24 22 36

   * - Function
     - MCXN947 block
     - Zephyr node
     - Connected device / notes
   * - IMU
     - FlexComm 8 (LPSPI)
     - ``flexcomm8_lpspi8`` -> ``icm45686_hub@0``
     - TDK ICM-45686. ``invensense,icm45686``; INT ``gpio3 22``; 20 MHz.
   * - Magnetometer
     - I3C0 *(→ LPI2C1 in workaround)*
     - ``i3c0`` / ``flexcomm1_lpi2c1`` -> ``bmm350_0``
     - Bosch BMM350, addr ``0x14``; DRDY ``gpio0 19``; ``bosch,bmm350``.
   * - Barometer
     - I3C0
     - ``i3c0`` -> ``bmp581_0``
     - Bosch BMP581, addr ``0x47``; ``bosch,bmp581``. *Disabled in workaround.*
   * - Ethernet
     - ENET0 (RMII) + MDIO
     - ``enet`` / ``enet_mac`` / ``enet_mdio`` -> ``phy@12``
     - NXP TJA1103 100BASE-T1 PHY at MDIO addr ``0x12``; ``nxp,tja1103``; INT ``gpio1 19``; RMII.
   * - CAN 0
     - FlexCAN 0
     - ``flexcan0`` + ``can_phy0``
     - NXP TJA1462; ``nxp,tja1462``; STB ``gpio4 14``; max 5 Mbit/s. ``zephyr,canbus``.
   * - CAN 1
     - FlexCAN 1
     - ``flexcan1`` + ``can_phy1``
     - NXP TJA1462; ``nxp,tja1462``; STB ``gpio4 17``; max 5 Mbit/s.
   * - USB
     - USB1 FS + PHY
     - ``usb1`` (``zephyr_udc0``) + ``usbphy1``
     - USB Type-C; also hosts the CDC-ACM console in the workaround config.
   * - Console UART
     - FlexComm 1 (LPUART)
     - ``flexcomm1_lpuart1``
     - 115200 baud; ``P0_25`` TXD / ``P0_24`` RXD. *Disabled in workaround (USB CDC-ACM used).*
   * - RGB LED
     - FLEXIO0 (SPI)
     - ``flexio0`` -> ``led_strip`` (``apa,apa102``)
     - Addressable LED via FlexIO-SPI; ``P0_8`` SDO/SDI, ``P0_9`` SCK; alias ``led-strip``.
   * - Watchdog / RTC
     - WWDT0 / RTC
     - ``wwdt0`` / ``rtc``
     - aliases ``watchdog0``, ``rtc``.

Chosen Nodes and Aliases
========================

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - chosen / alias
     - Node
   * - ``zephyr,console`` / ``zephyr,shell-uart`` / ``zephyr,uart-mcumgr``
     - ``flexcomm1_lpuart1`` (nominal) → ``snippet_cdc_acm_console_uart`` (workaround)
   * - ``zephyr,canbus``
     - ``flexcan0``
   * - ``zephyr,sram`` / ``zephyr,flash`` / ``zephyr,code-partition``
     - ``sram0`` / ``flash`` / ``slot0_partition``
   * - ``led-strip``
     - ``led_strip`` (APA102)
   * - ``watchdog0`` / ``rtc``
     - ``wwdt0`` / ``rtc``

Flash Partitions
================

.. list-table::
   :header-rows: 1
   :widths: 24 20 20 36

   * - Partition
     - Label
     - Offset
     - Size
   * - ``boot_partition``
     - mcuboot
     - ``0x00000000``
     - 80 KB
   * - ``slot0_partition``
     - image-0
     - ``0x00014000``
     - 984 KB
   * - ``slot1_partition``
     - image-1
     - ``0x0010A000``
     - 984 KB

MCXN947 Pin-Mux (base board)
============================

.. list-table::
   :header-rows: 1
   :widths: 12 26 30 20

   * - MCU Pin
     - Applied Signal (schematic)
     - Zephyr pinctrl / node (DTS)
     - Block
   * - ``P0_0``
     - ``DEBUG_TMS_SWDIO``
     - *(not in DTS)*
     - Debug/SWD
   * - ``P0_1``
     - ``DEBUG_TCLK_SWCLK``
     - *(not in DTS)*
     - Debug/SWD
   * - ``P0_2``
     - ``DEBUG_TDO_SWO``
     - *(not in DTS)*
     - Debug/SWD
   * - ``P0_3``
     - ``DEBUG_TDI``
     - *(not in DTS)*
     - Debug/SWD
   * - ``P0_4``
     - ``DEBUG_GPIO``
     - *(not in DTS)*
     - Debug/SWD
   * - ``P0_7``
     - ``FC0_P3``
     - *(not in DTS)*
     - Expansion connector
   * - ``P0_8``
     - ``FLEXIO0_D0``
     - ``flexio0 / flexio_spi0``
     - RGB LED
   * - ``P0_9``
     - ``FLEXIO0_D1``
     - ``flexio0 / flexio_spi0``
     - RGB LED
   * - ``P0_11``
     - ``BMP581_I2C_INT``
     - *(not in DTS)*
     - Sensor INT
   * - ``P0_16``
     - ``FC0_P0``
     - *(not in DTS)*
     - Expansion connector
   * - ``P0_17``
     - ``FC0_P1``
     - *(not in DTS)*
     - Expansion connector
   * - ``P0_18``
     - ``FC0_P2``
     - *(not in DTS)*
     - Expansion connector
   * - ``P0_19``
     - ``BMM350_I2C_INT``
     - *(not in DTS)*
     - Sensor INT
   * - ``P0_20``
     - ``I3C0_SDA``
     - ``flexcomm1_lpi2c1 (LPI2C, I3C workaround)``
     - Sensors (I3C0)
   * - ``P0_21``
     - ``I3C0_SCL``
     - ``flexcomm1_lpi2c1 (LPI2C, I3C workaround)``
     - Sensors (I3C0)
   * - ``P0_22``
     - ``FC0_P6``
     - *(not in DTS)*
     - Expansion connector
   * - ``P0_23``
     - ``FLEXIO0_D7``
     - *(not in DTS)*
     - RGB LED
   * - ``P0_24``
     - ``FC1_P0_UART_RXD``
     - ``flexcomm1_lpuart1 (LPUART, console)``
     - Console UART
   * - ``P0_25``
     - ``FC1_P1_UART_TXD``
     - ``flexcomm1_lpuart1 (LPUART, console)``
     - Console UART
   * - ``P0_31``
     - ``ENET0_WAKE_IN_OUT``
     - *(not in DTS)*
     - Ethernet
   * - ``P1_4``
     - ``ENET0_REFCLK``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_5``
     - ``ENET0_TXEN``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_6``
     - ``ENET0_TXD0``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_7``
     - ``ENET0_TXD1``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_8``
     - ``I3C1_SDA``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_9``
     - ``I3C1_SCL``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_10``
     - ``ENET0_TXER``
     - *(not in DTS)*
     - Ethernet
   * - ``P1_11``
     - ``ENET0_NRST``
     - *(not in DTS)*
     - Ethernet
   * - ``P1_12``
     - ``ENET0_RXER``
     - *(not in DTS)*
     - Ethernet
   * - ``P1_13``
     - ``ENET0_RXDV``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_14``
     - ``ENET0_RXD0``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_15``
     - ``ENET0_RXD1``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_16``
     - ``FC3_P4``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_17``
     - ``FC3_P5``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_18``
     - ``FC3_P6``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_19``
     - ``ENET0_INT_N``
     - *(not in DTS)*
     - Ethernet
   * - ``P1_20``
     - ``ENET0_MDC``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_21``
     - ``ENET0_MDIO``
     - ``enet (ENET QOS, RMII)``
     - Ethernet
   * - ``P1_22``
     - ``FC4_P2``
     - *(not in DTS)*
     - Expansion connector
   * - ``P1_23``
     - ``FC4_P3``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_0``
     - ``SDHC0_D5``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_1``
     - ``SDHC0_D4``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_6``
     - ``SDHC0_D3``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_7``
     - ``SDHC0_D2``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_8``
     - ``SDHC0_D7``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_9``
     - ``SDHC0_D6``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_10``
     - ``TRACE_DATA2``
     - *(not in DTS)*
     - Expansion connector
   * - ``P2_11``
     - ``TRACE_DATA3``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_0``
     - ``SmartDMA_PIO0``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_7``
     - ``SmartDMA_PIO7``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_8``
     - ``SmartDMA_PIO8``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_9``
     - ``SmartDMA_PIO9``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_12``
     - ``FC7_P4``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_13``
     - ``FC6_P5``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_14``
     - ``FC8_P0_SPI_SDO``
     - ``flexcomm8_lpspi8 (LPSPI)``
     - IMU (SPI FC8)
   * - ``P3_15``
     - ``FC8_P1_SPI_SCK``
     - ``flexcomm8_lpspi8 (LPSPI)``
     - IMU (SPI FC8)
   * - ``P3_16``
     - ``FC8_P2_SPI_SDI``
     - ``flexcomm8_lpspi8 (LPSPI)``
     - IMU (SPI FC8)
   * - ``P3_17``
     - ``FC8_P3_SPI_PCS0``
     - ``flexcomm8_lpspi8 (LPSPI)``
     - IMU (SPI FC8)
   * - ``P3_18``
     - ``FC6_P6``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_19``
     - ``FC7_P6``
     - *(not in DTS)*
     - Expansion connector
   * - ``P3_21``
     - ``FLEXIO0_D29``
     - *(not in DTS)*
     - RGB LED
   * - ``P3_22``
     - ``FC8_P6_SPI_HREQ``
     - *(not in DTS)*
     - IMU (SPI FC8)
   * - ``P4_0``
     - ``FC2_P0``
     - *(not in DTS)*
     - Expansion connector
   * - ``P4_1``
     - ``FC2_P1``
     - *(not in DTS)*
     - Expansion connector
   * - ``P4_2``
     - ``FC2_P2``
     - *(not in DTS)*
     - Expansion connector
   * - ``P4_3``
     - ``FC2_P3``
     - *(not in DTS)*
     - Expansion connector
   * - ``P4_12``
     - ``CAN0_RXD``
     - ``flexcan0``
     - CAN
   * - ``P4_13``
     - ``CAN0_TXD``
     - ``flexcan0``
     - CAN
   * - ``P4_14``
     - ``CAN0_STB``
     - *(not in DTS)*
     - CAN
   * - ``P4_15``
     - ``CAN1_RXD``
     - ``flexcan1``
     - CAN
   * - ``P4_16``
     - ``CAN1_TXD``
     - ``flexcan1``
     - CAN
   * - ``P4_17``
     - ``CAN1_STB``
     - *(not in DTS)*
     - CAN
   * - ``P4_20``
     - ``FC2_P4``
     - *(not in DTS)*
     - Expansion connector
   * - ``P4_23``
     - ``FC2_P6``
     - *(not in DTS)*
     - Expansion connector

Board-to-Board Expansion Connector
==================================

The mezzanine connector exposes the following MCXN947 signals to shields.
Shields refine these generic FlexComm signals into concrete SPI/UART/I2C roles.

.. list-table::
   :header-rows: 1
   :widths: 16 40

   * - MCU Pin
     - Exposed Signal
   * - ``P0_7``
     - ``FC0_P3``
   * - ``P0_16``
     - ``FC0_P0``
   * - ``P0_17``
     - ``FC0_P1``
   * - ``P0_18``
     - ``FC0_P2``
   * - ``P0_22``
     - ``FC0_P6``
   * - ``P0_23``
     - ``FLEXIO0_D7``
   * - ``P1_0``
     - ``FC3_P0``
   * - ``P1_1``
     - ``FC3_P1``
   * - ``P1_2``
     - ``FC3_P2``
   * - ``P1_3``
     - ``FC3_P3``
   * - ``P1_8``
     - ``I3C1_SDA``
   * - ``P1_9``
     - ``I3C1_SCL``
   * - ``P1_16``
     - ``FC3_P4``
   * - ``P1_17``
     - ``FC3_P5``
   * - ``P1_18``
     - ``FC3_P6``
   * - ``P1_22``
     - ``FC4_P2``
   * - ``P1_23``
     - ``FC4_P3``
   * - ``P2_0``
     - ``SDHC0_D5``
   * - ``P2_1``
     - ``SDHC0_D4``
   * - ``P2_2``
     - ``SDHC0_D1``
   * - ``P2_3``
     - ``SDHC0_D0``
   * - ``P2_4``
     - ``SDHC0_CLK``
   * - ``P2_5``
     - ``SDHC0_CMD``
   * - ``P2_6``
     - ``SDHC0_D3``
   * - ``P2_7``
     - ``SDHC0_D2``
   * - ``P2_8``
     - ``SDHC0_D7``
   * - ``P2_9``
     - ``SDHC0_D6``
   * - ``P2_10``
     - ``TRACE_DATA2``
   * - ``P2_11``
     - ``TRACE_DATA3``
   * - ``P3_0``
     - ``SmartDMA_PIO0``
   * - ``P3_1``
     - ``FC6_P0``
   * - ``P3_2``
     - ``FC7_P0``
   * - ``P3_3``
     - ``FC7_P1``
   * - ``P3_4``
     - ``FC7_P2``
   * - ``P3_5``
     - ``FC7_P3``
   * - ``P3_6``
     - ``FC6_P1``
   * - ``P3_7``
     - ``SmartDMA_PIO7``
   * - ``P3_8``
     - ``SmartDMA_PIO8``
   * - ``P3_9``
     - ``SmartDMA_PIO9``
   * - ``P3_10``
     - ``FC6_P2``
   * - ``P3_11``
     - ``FC6_P3``
   * - ``P3_12``
     - ``FC7_P4``
   * - ``P3_13``
     - ``FC6_P5``
   * - ``P3_18``
     - ``FC6_P6``
   * - ``P3_19``
     - ``FC7_P6``
   * - ``P3_21``
     - ``FLEXIO0_D29``
   * - ``P4_0``
     - ``FC2_P0``
   * - ``P4_1``
     - ``FC2_P1``
   * - ``P4_2``
     - ``FC2_P2``
   * - ``P4_3``
     - ``FC2_P3``
   * - ``P4_20``
     - ``FC2_P4``
   * - ``P4_23``
     - ``FC2_P6``

Bootloader (MCUboot)
********************

The board ships with an MCUboot integration under ``boards/nxp/mr_mcxn_t1/mcuboot``.
MCUboot is built for this target with a dedicated overlay and config:

* ``mr_mcxn_t1_mcxn947_cpu0.overlay`` sets ``chosen { zephyr,code-partition = &boot_partition; }``
  so MCUboot links at the boot partition (``0x0``) rather than the app slot, and
  enables ``&flexcomm1_lpuart1`` to pull in the ``lpflexcomm`` driver required by
  the MFD driver.
* ``mr_mcxn_t1_mcxn947_cpu0.conf`` disables the unused ``I2C``/``I3C``/``SENSOR``
  subsystems for the bootloader and enables ``SERIAL`` + ``UART_MCUX_LPUART``.
* ``mcuboot.cmake`` wires the overlay/conf in. Typical build::

     west build -b mr_mcxn_t1/mcxn947/cpu0 bootloader/mcuboot/boot/zephyr \
        -- -C <board_dir>/mcuboot/mcuboot.cmake

.. note::

   Historical context: an earlier revision of the MCUboot overlay omitted the
   ``zephyr,code-partition`` setting, so MCUboot was linked at the app slot
   address (``0x14000``) and the application HardFaulted. The current overlay
   fixes this and enables the LPUART/lpflexcomm dependency.

Programming and Debugging
*************************

* **SWD**: ``P0_0`` SWDIO / ``P0_1`` SWCLK / ``P0_2`` SWO / ``P0_3`` TDI /
  ``P0_4`` GPIO, plus ``RESET_b`` on the 10-pin Pixhawk debug connector.
* **Console**: LPUART1 (``P0_25`` TXD / ``P0_24`` RXD) nominally; USB CDC-ACM in
  the as-built workaround config.

References
**********

