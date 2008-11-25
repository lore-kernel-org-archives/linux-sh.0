From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Nov 2008 13:00:41 +0000
Subject: [PATCH 5/8] sh: timer rewrite V2, sh7722 support
Message-Id: <20081125130041.8587.86950.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add CMT and TMU devices and use the new timer code V2 on sh7722.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   45 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

--- 0005/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-25 20:26:34.000000000 +0900
@@ -356,6 +356,7 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-11-25 20:26:54.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -343,6 +344,50 @@ void __init plat_irq_setup(void)
 	register_intc_controller(&intc_desc);
 }
 
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
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(timers, ARRAY_SIZE(timers));
+}
+
 void __init plat_mem_setup(void)
 {
 	/* Register the URAM space as Node 1 */
