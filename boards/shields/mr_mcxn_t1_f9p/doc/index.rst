

.. _mr_mcxn_t1_f9p:

MR-MCXN-T1 F9P Shield (GNSS)
######################################

Overview
********

**mr_mcxn_t1_f9p** is an add-on board (Zephyr shield) for the
:ref:`mr_mcxn_t1` base board. It provides high-precision, multi-band GNSS
and RTK positioning via a u-blox NEO-F9P-15B receiver module. The add-on
board includes a USB-C connector, a GPS antenna connector, and a battery
connector for battery-backed operation of the NEO-F9P-15B.


Add-on Components
*****************

.. list-table::
   :header-rows: 1
   :widths: 22 12 20 20 26

   * - Device
     - Designator
     - Zephyr binding
     - Bus / node
     - Key parameters
   * - u-blox NEO-F9P-15B (GNSS/RTK)
     - U5
     - ``u-blox,f9p``
     - FlexComm7 LPUART7 -> ``gnss1``
     - 38400 baud, 1 Hz fix rate; supports battery-backed operation;
       external reset and interrupt pins available.

External Connectors
*******************

.. list-table::
   :header-rows: 1
   :widths: 14 14 20 52

   * - Function
     - Designator
     - Interface
     - Notes
   * - Board-to-board
     - J1, J2
     - UART, I2C
     - Connects to J8, J9 on the MR-MCXN-T1 board.
   * - USB-C
     - USB1
     - USB
     - connected to NEO-F9P-15B USB port (the MR-MCXN-T1 F9P
       Shield board needs to be powered by the MR-MCXN-T1).
   * - GPS antenna
     - ANT1
     - RF / GPS
     - ANT 50R external GPS antenna connector.
   * - UART
     - J3
     - UART
     - Passthrough UART (i.e Corrections Radio).
   * - TIMEPULSE
     - J3
     - GPIO
     - Time pulse output from NEO-F9P-15B.
   * - Battery
     - BAT1
     - V_BACKUP
     - GPS 3.3V.

Other Functionalities
*********************

.. list-table::
   :header-rows: 1
   :widths: 14 14 20 20 52

   * - Function
     - MCU pin
     - Designator
     - Interface
     - Notes
   * - External interrupt
     - P3_0 / FC7_P3 / EXTINT
     -
     - GPIO
     - External interrupt input to NEO-F9P-15B.
   * - Hardware reset
     - P3_7 / FC6_P6 / RESET_N
     -
     - GPIO
     - Active-low hardware reset for NEO-F9P-15B.
   * - Timepulse
     - P3_8 / FC6_P4 / TIMEPULSE
     -
     - GPIO
     - Time pulse output from NEO-F9P-15B.
   * - User switches
     - P1_2 / FC3_P2, P1_3 / FC3_P3
     - SW1, SW2
     - GPIO
     - Connects to P1_2 and P1_3 on MR-MCXN-T1.


Bus / Pinctrl Usage
*******************

The F9P shield consumes the FlexComm7 port from the expansion
connector, configured as **LPUART7**:

.. list-table::
   :header-rows: 1
   :widths: 12 16 18 28

   * - MCU pin
     - Zephyr pinctrl group
     - Role
     - F9P pin
   * - ``P3_2 / FC7_P0``
     - ``pinmux_flexcomm7_lpuart``
     - LPUART7 RXD
     - F9P UART1 TX
   * - ``P3_3 / FC7_P1``
     - ``pinmux_flexcomm7_lpuart``
     - LPUART7 TXD
     - F9P UART1 RX

GNSS Driver Configuration
**************************

The shield uses the ``u-blox,f9p`` Zephyr driver (see
``dts/bindings/gnss/u-blox,f9p.yaml`` and ``u-blox,common.yaml``).
Relevant device-tree properties:

.. list-table::
   :header-rows: 1
   :widths: 28 12 60

   * - Property
     - Default
     - Description
   * - ``current-speed``
     - —
     - UART baud rate on the MCU side (set on the parent LPUART node).
       Must match the baud rate configured on the NEO-F9P-15B.
   * - ``initial-baudrate``
     - 38400
     - Baud rate the F9P uses at power-on. The driver connects at this rate
       first, then switches to ``current-speed``.
   * - ``fix-rate``
     - 1000
     - GNSS navigation update interval in milliseconds (min 50, max 65535).
       1000 ms = 1 Hz. Adjustable at runtime via the Zephyr GNSS API.
   * - ``reset-gpios``
     - —
     - Optional GPIO to hardware-reset the GNSS module.

The shield overlay (``mr_mcxn_t1_f9p.overlay``) configures the F9P driver
to communicate with the module over UART1 (``UBX_KEY_..._UART1``), which maps to
FlexComm7 on the MCU side.

Required Kconfig options (set automatically via ``mr_mcxn_t1_f9p.conf``):

.. code-block:: kconfig

   CONFIG_SERIAL=y
   CONFIG_UART_INTERRUPT_DRIVEN=y

Programming
***********

The :zephyr:code-sample:`gnss` sample demonstrates GNSS functionality using
this shield.

Set ``-DSHIELD=mr_mcxn_t1_f9p`` when you invoke ``west build``. For example:

.. code-block:: console

   # From the root of the Zephyr repository
   west build -p always -b mr_mcxn_t1/mcxn947/cpu0 samples/drivers/gnss -DSHIELD=mr_mcxn_t1_f9p

References
**********

* :ref:`mr_mcxn_t1` -- MR-MCXN-T1 base board
* `u-blox NEO-F9P product page <https://www.u-blox.com/en/product/neo-f9p-module>`_