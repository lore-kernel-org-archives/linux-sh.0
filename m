From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 08 Oct 2008 11:41:35 +0000
Subject: [PATCH 00/09] sh: SuperH GPIO V2
Message-Id: <20081008114135.25282.17004.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pinmuxed GPIO support for SuperH V2

[PATCH 01/09] sh: GPIO and pinmux base code
[PATCH 02/09] sh: Add sh7722 pinmux code
[PATCH 03/09] sh: Use sh7722 GPIO on Migo-R board
[PATCH 04/09] sh: Add sh7723 pinmux code
[PATCH 05/09] sh: Use sh7723 GPIO on AP325RXA board
[PATCH 06/09] sh: Add sh7203 pinmux code
[PATCH 07/09] sh: Use sh7203 GPIO on rsk7203 board
[PATCH 08/09] sh: Add sh7720 pinmux code
[PATCH 09/09] sh: Use sh7720 GPIO on magicpanelr2 board

These patches add GPIO support to the SuperH architecture. The regular
GPIO operations are all supported for configuring and reading/writing
pin data.  IRQs and user space exporting are not supported at this point.

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

Changes since V1 include:
 - dropped gpiolib for now to work around merge order issues
 - whitespace cleanups
 - folded in static fix from paul
 - added sh7203 and sh7720 processor and board support

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                         |    3 
 arch/sh/boards/Kconfig                  |    4 
 arch/sh/boards/board-ap325rxa.c         |  100 +
 arch/sh/boards/board-magicpanelr2.c     |   11 
 arch/sh/boards/board-rsk7203.c          |   11 
 arch/sh/boards/mach-migor/lcd_qvga.c    |    6 
 arch/sh/boards/mach-migor/setup.c       |  187 +--
 arch/sh/include/asm/gpio.h              |   92 +
 arch/sh/include/asm/sh7203.h            |  143 ++
 arch/sh/include/asm/sh7720.h            |  174 ++
 arch/sh/include/asm/sh7722.h            |  210 +++
 arch/sh/include/asm/sh7723.h            |  254 ++++
 arch/sh/kernel/Makefile_32              |    2 
 arch/sh/kernel/Makefile_64              |    2 
 arch/sh/kernel/cpu/sh2a/Makefile        |    5 
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c | 1599 +++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh3/Makefile         |    4 
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c  | 1242 ++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/Makefile        |    5 
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c | 1783 ++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c | 1909 +++++++++++++++++++++++++++++++
 arch/sh/kernel/gpio.c                   |  498 ++++++++
 22 files changed, 8144 insertions(+), 100 deletions(-)
