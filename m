From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 10:32:03 +0000
Subject: [PATCH v5 0/5] Renesas TPU PWM support
Message-Id: <1373970728-28648-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is the fifth version of the Renesas TPU PWM unit support patches. Now
that the TPU PWM driver has been merged, we can replace leds-renesas-tpu
usage with a combination of leds-pwm and renesas-tpu-pwm.

As an added bonus patch 4/5 removes function GPIOs support from the sh73a0
platform. mach-shmobile is now free of function GPIOs. Once again we still
need volunteer(s) to migrate arch/sh.

I've tested the code on Armadillo only as I don't have access to a kota2
board. This is why I've added backlight support to Armadillo as part of this
set.

The patches are based on Simon's renesas-devel-20130716 tag.

The last patch in the series remove the leds-renesas-tpu driver. It would be
easier to merge it through Simon's tree as there is little risks of conflict.
If Bryan or Richard would prefer to take it in the LEDs tree I have no
objection, but we will then need to provide a stable branch with the first
four patches.

Changes sinve v4:

- Dropped the patch that adds the TPU PWM driver as it has been merged
  upstream
- Fix the TPU device name in clock entries

Changes since v3:

- Set the driver name to renesas-tpu-pwm instead of renesas_tpu_pwm
- Allocate the PWM device in the request handler
- Fixed device name in sh73a0 clocks lookup array
- Added support for TPU0 on sh73a0

Changes since v2:

- Dropped SH Mobile arch patches that have already been merged
- Replaced active_low pdata field with pwm_polarity
- Replaced TPU_PWM_ID with pwm_lookup's
- Set the platform_driver .owner field
- Replaced devm_ioremap_nocache() with devm_ioremap_resource()
- Added a .set_polarity() implementation
- Use kernel block comment style
- Don't enable/disable the clock around clk_get_rate()
- Removed duplicate sanity checks in the .config() operation

Changes since v1:

- Renamed the pwm-rmob driver to pwm-renesas-tpu, as TPU units are found in
  Renesas SH-Mobile, R-Mobile and R-Car SoCs.
- Added TPU clock and pin groups for r8a7790.

Laurent Pinchart (5):
  ARM: shmobile: r8a7740: Fix TPU clock name
  ARM: shmobile: armadillo800eva: Add backlight support
  ARM: shmobile: kota2: Use leds-pwm + pwm-rmob
  ARM: shmobile: sh73a0: Remove all GPIOs
  leds: Remove leds-renesas-tpu driver

 arch/arm/mach-shmobile/board-armadillo800eva.c |  54 +++-
 arch/arm/mach-shmobile/board-kota2.c           | 169 ++++++-----
 arch/arm/mach-shmobile/clock-r8a7740.c         |   2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c          |  12 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   | 373 +------------------------
 drivers/leds/Kconfig                           |  12 -
 drivers/leds/Makefile                          |   1 -
 drivers/leds/leds-renesas-tpu.c                | 337 ----------------------
 include/linux/platform_data/leds-renesas-tpu.h |  14 -
 9 files changed, 144 insertions(+), 830 deletions(-)
 delete mode 100644 drivers/leds/leds-renesas-tpu.c
 delete mode 100644 include/linux/platform_data/leds-renesas-tpu.h

-- 
Regards,

Laurent Pinchart

