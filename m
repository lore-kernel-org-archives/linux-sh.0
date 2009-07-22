From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Jul 2009 16:20:54 +0000
Subject: [PATCH] sh: kfr2r09 board support - SCIF console
Message-Id: <20090722162054.18165.73500.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds basic kfr2r09 board support. Only
the SCIF1 console is supported with this patch, but
this patch and a proper sh7724 configuration is all
that is needed. Combine with an initramfs to have a
small RAM based kernel and distribution booted as
zImage from RAM via JTAG.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 I'll post a defconfig later on when we have agreed
 on how to handle the zImage boot loader stuff.

 arch/sh/Makefile                     |    1 
 arch/sh/boards/Kconfig               |    7 ++++
 arch/sh/boards/mach-kfr2r09/Makefile |    1 
 arch/sh/boards/mach-kfr2r09/setup.c  |   48 ++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-07-22 22:05:57.000000000 +0900
@@ -136,6 +136,7 @@ machdir-$(CONFIG_SH_7751_SYSTEMH)		+= ma
 machdir-$(CONFIG_SH_EDOSK7705)			+= mach-edosk7705
 machdir-$(CONFIG_SH_HIGHLANDER)			+= mach-highlander
 machdir-$(CONFIG_SH_MIGOR)			+= mach-migor
+machdir-$(CONFIG_SH_KFR2R09)			+= mach-kfr2r09
 machdir-$(CONFIG_SH_SDK7780)			+= mach-sdk7780
 machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
 machdir-$(CONFIG_SH_SH7763RDP)			+= mach-sh7763rdp
--- 0001/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2009-07-22 22:05:57.000000000 +0900
@@ -193,6 +193,13 @@ config SH_AP325RXA
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"
 
+config SH_KFR2R09
+	bool "KFR2R09"
+	depends on CPU_SUBTYPE_SH7724
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  "Kit For R2R for 2009" support.
+
 config SH_SH7763RDP
 	bool "SH7763RDP"
 	depends on CPU_SUBTYPE_SH7763
--- /dev/null
+++ work/arch/sh/boards/mach-kfr2r09/Makefile	2009-07-22 22:05:57.000000000 +0900
@@ -0,0 +1 @@
+obj-y	 := setup.o
--- /dev/null
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-07-23 00:31:19.000000000 +0900
@@ -0,0 +1,48 @@
+/*
+ * KFR2R09 board support code
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <asm/clock.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
+#include <cpu/sh7724.h>
+
+static int __init kfr2r09_devices_setup(void)
+{
+	/* enable SCIF1 serial port for YC401 console support */
+	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
+	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
+
+	return 0;
+}
+device_initcall(kfr2r09_devices_setup);
+
+/* Return the board specific boot mode pin configuration */
+static int kfr2r09_mode_pins(void)
+{
+	/* MD0=1, MD1=1, MD2=0: Clock Mode 3
+	 * MD3=0: 16-bit Area0 Bus Width
+	 * MD5=1: Little Endian
+	 * MD8=1: Test Mode Disabled
+	 */
+	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5 | MODE_PIN8;
+}
+
+/*
+ * The Machine Vector
+ */
+static struct sh_machine_vector mv_kfr2r09 __initmv = {
+	.mv_name		= "kfr2r09",
+	.mv_mode_pins		= kfr2r09_mode_pins,
+};
