From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Nov 2008 13:21:44 +0000
Subject: [PATCH 7/8] sh: timer rewrite, sh7343 support
Message-Id: <20081121132144.4219.39181.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add CMT and TMU devices and use the new timer code on sh7343.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   46 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

--- 0007/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-21 17:22:55.000000000 +0900
@@ -350,6 +350,7 @@ config CPU_SUBTYPE_SHX3
 config CPU_SUBTYPE_SH7343
 	bool "Support SH7343 processor"
 	select CPU_SH4AL_DSP
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7722
 	bool "Support SH7722 processor"
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-11-21 17:24:15.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 
 static struct resource iic0_resources[] = {
@@ -292,3 +293,48 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct sh_timer_config timers[] = {
+	{
+		.type = SH_TIMER_TYPE_CMT,
+		.name = "CMT",
+		.base = 0x044a0000,
+		.channel_offset = 0x60,
+		.timer_bit = 5,
+		.clk = "cmt0",
+		.irq = 104,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU0",
+		.base = 0xffd80004,
+		.channel_offset = 0x04,
+		.timer_bit = 0,
+		.clk = "tmu0",
+		.irq = 16,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU1",
+		.base = 0xffd80004,
+		.channel_offset = 0x10,
+		.timer_bit = 1,
+		.clk = "tmu0",
+		.irq = 17,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU2",
+		.base = 0xffd80004,
+		.channel_offset = 0x1c,
+		.timer_bit = 2,
+		.clk = "tmu0",
+		.irq = 18,
+	}
+};
+
+static int __init plat_timer_setup(void)
+{
+	return sh_timer_register(timers, ARRAY_SIZE(timers));
+}
+arch_initcall(plat_timer_setup);
