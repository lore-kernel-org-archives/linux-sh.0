From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 12:00:25 +0000
Subject: [PATCH] sh: sh7785lcr mode pin configuration
Message-Id: <20090528120025.5834.4382.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds mode pin support to the sh7785lcr board.

The harware allows the user to control the mode pins using
dip switches S1 and S2, but from the software the pins are
fixed to the factory default since we have no way to reading
out this configuration from software.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-sh7785lcr.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- 0001/arch/sh/boards/board-sh7785lcr.c
+++ work/arch/sh/boards/board-sh7785lcr.c	2009-05-28 18:48:03.000000000 +0900
@@ -24,6 +24,7 @@
 #include <mach/sh7785lcr.h>
 #include <asm/heartbeat.h>
 #include <asm/clock.h>
+#include <cpu/sh7785.h>
 
 /*
  * NOTE: This board has 2 physical memory maps.
@@ -320,6 +321,26 @@ static void __init sh7785lcr_setup(char 
 	writel(0x000307c2, sm501_reg);
 }
 
+/* Return the board specific boot mode pin configuration */
+static int sh7785lcr_mode_pins(void)
+{
+	int value = 0;
+
+	/* These are the factory default settings of S1 and S2.
+	 * If you change these dip switches then you will need to
+	 * adjust the values below as well.
+	 */
+	value |= 1 << MODE_PIN_MODE4; /* Clock Mode 16 */
+	value |= 1 << MODE_PIN_MODE5; /* 32-bit Area0 bus width */
+	value |= 1 << MODE_PIN_MODE6; /* 32-bit Area0 bus width */
+	value |= 1 << MODE_PIN_MODE7; /* Area 0 SRAM interface [fixed] */
+	value |= 1 << MODE_PIN_MODE8; /* Little Endian */
+	value |= 1 << MODE_PIN_MODE9; /* Master Mode */
+	value |= 1 << MODE_PIN_MODE14; /* No PLL step-up */
+
+	return value;
+}
+
 /*
  * The Machine Vector
  */
@@ -328,5 +349,6 @@ static struct sh_machine_vector mv_sh778
 	.mv_setup		= sh7785lcr_setup,
 	.mv_clk_init		= sh7785lcr_clk_init,
 	.mv_init_irq		= init_sh7785lcr_IRQ,
+	.mv_mode_pins		= sh7785lcr_mode_pins,
 };
 
