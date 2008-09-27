From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 27 Sep 2008 18:10:08 +0000
Subject: [PATCH 00/05] sh: GPIO for SuperH using gpiolib
Message-Id: <20080927181008.11246.53495.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pinmuxed GPIO support for SuperH using gpiolib

[PATCH 01/05] sh: Add GPIO and pinmux base code
[PATCH 02/05] sh: Add sh7722 pinmux tables 
[PATCH 03/05] sh: Use sh7722 GPIO on Migo-R board
[PATCH 04/05] sh: Add sh7723 pinmux tables
[PATCH 05/05] sh: Use sh7723 GPIO on AP325RXA board

These patches add support for GPIO to SuperH. The regular GPIO operations
are all supported for configuring and reading/writing pin data.  IRQs are
not supported at this point.

The main feature of this patchset is the table based pinmux code. So far
the pinmux hardware has been configured by the board code by hand, using
pinmux register values. This is both slow and error prone. The table based
pinmux code give users a nice abstraction and allows them to describe their
hardware configuration pin by pin and let the pinmux code handle the details
such as register layout and dependencies.

The pinmux code is written so multiple GPIOs map to one physical pin.
So for example on sh7723, pin PTS5 can be accessed as regular Port S pin 5
GPIO, but it can also be locked to two different functions - as TX pin of
the SCIF1 serial port or as SDHI0D3 - a D3 pin on the first MMC interface.

This specific PTS5 pin is exported as 3 different GPIOs:
GPIO_PTS5
GPIO_FN_SCIF1_PTS_TXD
GPIO_FN_SDHI0D3_PTS
Only one at a time can be selected using gpio_request().

These patches include support for sh7722/Migo-R and sh7723/AP325RXA hardware. 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                         |    3 
 arch/sh/boards/Kconfig                  |    2 
 arch/sh/boards/board-ap325rxa.c         |  100 +
 arch/sh/boards/mach-migor/lcd_qvga.c    |    6 
 arch/sh/boards/mach-migor/setup.c       |  185 +--
 arch/sh/include/asm/gpio.h              |  118 +
 arch/sh/include/asm/sh7722.h            |  210 +++
 arch/sh/include/asm/sh7723.h            |  254 ++++
 arch/sh/kernel/Makefile_32              |    1 
 arch/sh/kernel/Makefile_64              |    1 
 arch/sh/kernel/cpu/sh4a/Makefile        |    5 
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c | 1776 ++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c | 1909 +++++++++++++++++++++++++++++++
 arch/sh/kernel/gpio.c                   |  436 +++++++
 14 files changed, 4903 insertions(+), 103 deletions(-)
