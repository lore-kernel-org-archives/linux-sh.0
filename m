From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Nov 2008 13:01:07 +0000
Subject: [PATCH 6/8] sh: timer rewrite V2, sh7723 support
Message-Id: <20081125130107.8588.35350.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add CMT and TMU devices and use the new timer code V2 on sh7723.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   72 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

--- 0008/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-25 21:10:27.000000000 +0900
@@ -311,6 +311,7 @@ config CPU_SUBTYPE_SH7723
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
+	select SH_TIMER
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-11-25 21:11:18.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -460,3 +461,74 @@ void __init plat_irq_setup(void)
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
+		.name = "TMU0_0",
+		.base = 0xffd80004,
+		.channel_offset = 0x04,
+		.timer_bit = 0,
+		.clk = "tmu0",
+		.irq = 16,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU0_1",
+		.base = 0xffd80004,
+		.channel_offset = 0x10,
+		.timer_bit = 1,
+		.clk = "tmu0",
+		.irq = 17,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU0_2",
+		.base = 0xffd80004,
+		.channel_offset = 0x1c,
+		.timer_bit = 2,
+		.clk = "tmu0",
+		.irq = 18,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU1_0",
+		.base = 0xffd90004,
+		.channel_offset = 0x04,
+		.timer_bit = 0,
+		.clk = "tmu1",
+		.irq = 57,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU1_1",
+		.base = 0xffd90004,
+		.channel_offset = 0x10,
+		.timer_bit = 1,
+		.clk = "tmu1",
+		.irq = 58,
+	},
+	{
+		.type = SH_TIMER_TYPE_TMU,
+		.name = "TMU1_2",
+		.base = 0xffd90004,
+		.channel_offset = 0x1c,
+		.timer_bit = 2,
+		.clk = "tmu1",
+		.irq = 59,
+	}
+};
+
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(timers, ARRAY_SIZE(timers));
+}
