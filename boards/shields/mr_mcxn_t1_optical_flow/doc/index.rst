.. _mr_mcxn_t1_oflo:

MR-MCXN-T1 OFLO Shield (Optical-Flow)
######################################

Overview
********

**mr_mcxn_t1_oflo** is an add-on board (Zephyr shield) for the
:ref:`mr_mcxn_t1` base board. It provides downward-facing optical-flow and
time-of-flight ranging plus additional IMUs, forming the optical-flow sensing
node when mounted on the MCXN947 base board via the board-to-board connector.

Add-on Sensors
**************

.. list-table::
   :header-rows: 1
   :widths: 22 24 20 34

   * - Device
     - Zephyr binding
     - Bus / node
     - Key parameters (from DTS)
   * - Broadcom AFBR-S50LX85D (ToF)
     - ``brcm,afbr-s50``
     - LPSPI3 -> ``afbr_s50@0``
     - 20 MHz; INT ``gpio1 18`` (active-low, pull-up); ODR 50; short-range, DFM 4x; explicit MOSI/SCK/MISO GPIO handoff (``priv_start``).
   * - PixArt PAA3905E1 (optical flow)
     - ``pixart,paa3905``
     - LPSPI9 -> ``paa3905@0``
     - 20 MHz; INT ``gpio2 0`` (active-low).
   * - TDK ICM-42688-P (IMU)
     - ``invensense,icm42688`` / ``invensense,icm4268x``
     - LPSPI6 -> ``icm42688_optical_flow@0``
     - 20 MHz; INT ``gpio3 18``; accel/gyro LN, 1000 Hz ODR, FS 16 g / 2000 dps; FIFO hi-res.
   * - TDK ICM-45686 (IMU)
     - ``invensense,icm45686``
     - LPSPI7 -> ``icm45686_optical_flow@0``
     - 20 MHz; INT ``gpio3 19``; accel FS 2 g / gyro FS 4000 dps @ 400 Hz; FIFO watermark 1.

Bus / Pinctrl Usage
*******************

The OFLO shield consumes the following FlexComm ports from the expansion
connector, all configured as **LPSPI** masters:

.. list-table::
   :header-rows: 1
   :widths: 18 22 26 20

   * - MCU Pin
     - Signal (schematic)
     - Zephyr pinctrl group / node
     - Role
   * - ``P1_0``
     - ``FC3_P0_SPI_SDO``
     - ``flexcomm3_lpspi3 (LPSPI)``
     - LPSPI (flexcomm3_lpspi3)
   * - ``P1_1``
     - ``FC3_P1_SPI_SCK``
     - ``flexcomm3_lpspi3 (LPSPI)``
     - LPSPI (flexcomm3_lpspi3)
   * - ``P1_2``
     - ``FC3_P2_SPI_SDI``
     - ``flexcomm3_lpspi3 (LPSPI)``
     - LPSPI (flexcomm3_lpspi3)
   * - ``P1_3``
     - ``FC3_P3_SPI_CS0``
     - ``flexcomm3_lpspi3 (LPSPI)``
     - LPSPI (flexcomm3_lpspi3)
   * - ``P2_2``
     - ``SDHC0_D1``
     - ``flexcomm9_lpspi9 (LPSPI)``
     - LPSPI (flexcomm9_lpspi9)
   * - ``P2_3``
     - ``SDHC0_D0``
     - ``flexcomm9_lpspi9 (LPSPI)``
     - LPSPI (flexcomm9_lpspi9)
   * - ``P2_4``
     - ``SDHC0_CLK``
     - ``flexcomm9_lpspi9 (LPSPI)``
     - LPSPI (flexcomm9_lpspi9)
   * - ``P2_5``
     - ``SDHC0_CMD``
     - ``flexcomm9_lpspi9 (LPSPI)``
     - LPSPI (flexcomm9_lpspi9)
   * - ``P3_1``
     - ``FC6_P0``
     - ``flexcomm6_lpspi6 (LPSPI)``
     - LPSPI (flexcomm6_lpspi6)
   * - ``P3_2``
     - ``FC7_P0_SPI_SDO``
     - ``flexcomm7_lpspi7 (LPSPI)``
     - LPSPI (flexcomm7_lpspi7)
   * - ``P3_3``
     - ``FC7_P1_SPI_SCK``
     - ``flexcomm7_lpspi7 (LPSPI)``
     - LPSPI (flexcomm7_lpspi7)
   * - ``P3_4``
     - ``FC7_P2_SPI_SDI``
     - ``flexcomm7_lpspi7 (LPSPI)``
     - LPSPI (flexcomm7_lpspi7)
   * - ``P3_5``
     - ``FC7_P3_SPI_CS0``
     - ``flexcomm7_lpspi7 (LPSPI)``
     - LPSPI (flexcomm7_lpspi7)
   * - ``P3_6``
     - ``FC6_P1``
     - ``flexcomm6_lpspi6 (LPSPI)``
     - LPSPI (flexcomm6_lpspi6)
   * - ``P3_10``
     - ``FC6_P2``
     - ``flexcomm6_lpspi6 (LPSPI)``
     - LPSPI (flexcomm6_lpspi6)
   * - ``P3_11``
     - ``FC6_P3``
     - ``flexcomm6_lpspi6 (LPSPI)``
     - LPSPI (flexcomm6_lpspi6)

.. note::

   * FlexComm 3 (LPSPI3) additionally defines a GPIO-mode pinctrl
     (``pinmux_flexcomm3_lpspi_gpio``) and a ``priv_start`` state; the AFBR-S50
     driver toggles MOSI/SCK/MISO as GPIOs during its private start-up sequence
     (``spi-mosi-gpios`` ``gpio1 0``, ``spi-sck-gpios`` ``gpio1 1``,
     ``spi-miso-gpios`` ``gpio1 2``), with CS on ``gpio1 3``.
   * FlexComm 9 (LPSPI9) uses the ``P2_2/3/4/5`` pins that appear as ``SDHC0_*``
     nets in the schematic; the DTS disambiguates them as the PAA3905 SPI bus.

References
**********
