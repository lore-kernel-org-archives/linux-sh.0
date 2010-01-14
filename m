From: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
Date: Thu, 14 Jan 2010 09:53:09 +0000
Subject: [PATCH] sh: mach-ecovec24: Add motion sensor driver support
Message-Id: <4B4EE985.3090908@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds support for lis3lv02d motion sensor driver
that use i2c interface to the Ecovec board.

I tested the driver with 'evtest' which is available
from a below link.
http://beagleboard.googlecode.com/files/evtest.c

Signed-off-by: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
---
arch/sh/boards/mach-ecovec24/setup.c | 10 ++++++++++
1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c
b/arch/sh/boards/mach-ecovec24/setup.c
index 6a8861b..2ea2df5 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -19,6 +19,7 @@
#include <linux/usb/r8a66597.h>
#include <linux/i2c.h>
#include <linux/i2c/tsc2007.h>
+#include <linux/lis3lv02d.h>
#include <linux/spi/spi.h>
#include <linux/spi/sh_msiof.h>
#include <linux/spi/mmc_spi.h>
@@ -349,10 +350,15 @@ static struct i2c_board_info i2c0_devices[] = {
},
};

+#define IRQ1 33
static struct i2c_board_info i2c1_devices[] = {
{
I2C_BOARD_INFO("r2025sd", 0x32),
},
+ {
+ I2C_BOARD_INFO("lis3lv02d", 0x1c),
+ .irq = IRQ1,
+ },
};

/* KEYSC */
@@ -1115,6 +1121,10 @@ static int __init arch_setup(void)
gpio_direction_output(GPIO_PTU0, 0);
mdelay(20);

+ /* enable motion sensor */
+ gpio_request(GPIO_FN_INTC_IRQ1, NULL);
+ gpio_direction_input(GPIO_FN_INTC_IRQ1);
+
/* enable I2C device */
i2c_register_board_info(0, i2c0_devices,
ARRAY_SIZE(i2c0_devices));
-- 
1.6.3.3


