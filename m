From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 19:13:23 +0000
Subject: [PATCH v2 0/7] Backlight drivers for SH and ARM SH-Mobile boards
Message-Id: <1372965210-10024-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are three backlight drivers used by SH and ARM SH-Mobile boards.

The first driver supports simple GPIO-controlled backlights that are turned on
or off by a single GPIO (either active high or active low).

The second driver supports the Sanyo LV5207LP LED driver
(http://www.onsemi.com/pub_link/Collateral/ENA0943-D.PDF) and exposes the main
LED only as a backlight device, as that's all the board I need to driver for
uses.

The third driver supports the ROHM Semiconductor BD6107 LED driver (no
datasheet publicly available I'm afraid). Similarly to the LV5207LP driver, it
exposes the main LED only as a backlight device.

The last four patches port the ARM SH-Mobile Mackerel and AG5EVM and the SH
Ecovec24 and KFR2R09 boards to use the new backlight drivers. The code has been
compile tested on all four platforms and runtime tested on Mackerel only as I
don't have access to the other boards.

As the board code patches depend on the backlight drivers, the drivers should
get merged first. Richard, Jingoo, would you like to take them through your
tree, or would it be easier to merge them with the ARM and SH patches ?

Laurent Pinchart (7):
  backlight: Add GPIO-based backlight driver
  backlight: Add Sanyo LV5207LP backlight driver
  backlight: Add ROHM BD6107 backlight driver
  ARM: mach-shmobile: mackerel: Use gpio-backlight
  sh: ecovec24: Use gpio-backlight
  sh: kfr2r09: Use lv5207lp backlight
  ARM: mach-shmobile: ag5evm: Use bd6107 backlight driver

 arch/arm/mach-shmobile/board-ag5evm.c        |  65 ++------
 arch/arm/mach-shmobile/board-mackerel.c      |  34 ++---
 arch/sh/boards/mach-ecovec24/setup.c         |  37 ++---
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c      |  48 ------
 arch/sh/boards/mach-kfr2r09/setup.c          |  19 ++-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h  |   2 -
 drivers/video/backlight/Kconfig              |  19 +++
 drivers/video/backlight/Makefile             |   3 +
 drivers/video/backlight/bd6107.c             | 213 +++++++++++++++++++++++++++
 drivers/video/backlight/gpio_backlight.c     | 133 +++++++++++++++++
 drivers/video/backlight/lv5207lp.c           | 171 +++++++++++++++++++++
 include/linux/platform_data/bd6107.h         |  19 +++
 include/linux/platform_data/gpio_backlight.h |  21 +++
 include/linux/platform_data/lv5207lp.h       |  19 +++
 14 files changed, 665 insertions(+), 138 deletions(-)
 create mode 100644 drivers/video/backlight/bd6107.c
 create mode 100644 drivers/video/backlight/gpio_backlight.c
 create mode 100644 drivers/video/backlight/lv5207lp.c
 create mode 100644 include/linux/platform_data/bd6107.h
 create mode 100644 include/linux/platform_data/gpio_backlight.h
 create mode 100644 include/linux/platform_data/lv5207lp.h

-- 
Regards,

Laurent Pinchart

