From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 May 2013 11:23:43 +0000
Subject: [PULL] Renesas TPU PWM support
Message-Id: <2913226.V7YaaHlrKR@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

The following changes since commit 12e47d7dae97ea9474da500a555dc781d3b7ee55:

  Merge branch 'heads/soc-sh73a0' into next (2013-05-09 12:53:26 +0900)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/tpu

for you to fetch changes up to 56c8a8e245ddc6e1601e230d366139fba8432273:

  leds: Remove leds-renesas-tpu driver (2013-05-09 13:00:18 +0200)

The patches have already been posted to the list, I've just rebased them on 
top of renesas-next-20130509. Feel free to pick them up manually or rebase 
them if needed, or even ask me to rebase them on top of a different 
branch/tag.

----------------------------------------------------------------
Laurent Pinchart (11):
      sh-pfc: sh73a0: Add TPU pin groups and functions
      sh-pfc: r8a7740: Add TPU pin groups and functions
      sh-pfc: r8a7790: Add TPU pin groups and functions
      pwm: Add Renesas TPU PWM driver
      ARM: mach-shmobile: clock-r8a7740: add TPU PWM support
      ARM: mach-shmobile: clock-r8a7790: add TPU PWM support
      ARM: mach-shmobile: armadillo800eva: Add backlight support
      ARM: mach-shmobile: kota2: Use leds-pwm + pwm-rmob
      sh-pfc: sh73a0: Remove function GPIOs
      ARM: shmobile: sh73a0: Remove all GPIOs
      leds: Remove leds-renesas-tpu driver

 arch/arm/mach-shmobile/board-armadillo800eva.c |  51 ++-
 arch/arm/mach-shmobile/board-kota2.c           | 178 ++++++----
 arch/arm/mach-shmobile/clock-r8a7740.c         |   4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c         |  11 +-
 arch/arm/mach-shmobile/clock-sh73a0.c          |   8 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   | 373 +-------------------
 drivers/leds/Kconfig                           |  12 -
 drivers/leds/Makefile                          |   1 -
 drivers/leds/leds-renesas-tpu.c                | 336 ------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  50 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c           |  41 +++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 608 +++++++++---------------
 drivers/pwm/Kconfig                            |   7 +
 drivers/pwm/Makefile                           |   1 +
 drivers/pwm/pwm-renesas-tpu.c                  | 462 ++++++++++++++++++++++++
 include/linux/platform_data/leds-renesas-tpu.h |  14 -
 include/linux/platform_data/pwm-renesas-tpu.h  |  18 +
 17 files changed, 963 insertions(+), 1212 deletions(-)
 delete mode 100644 drivers/leds/leds-renesas-tpu.c
 create mode 100644 drivers/pwm/pwm-renesas-tpu.c
 delete mode 100644 include/linux/platform_data/leds-renesas-tpu.h
 create mode 100644 include/linux/platform_data/pwm-renesas-tpu.h

-- 
Regards,

Laurent Pinchart

