From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Nov 2008 13:02:08 +0000
Subject: [PATCH 8/8] sh: timer rewrite V2, sh7366 support
Message-Id: <20081125130208.8591.66510.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add CMT and TMU devices and use the new timer code V2 on sh7366.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   46 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

--- 0011/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-25 21:18:37.000000000 +0900
@@ -366,6 +366,7 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 # SH-5 Processor Support
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-11-25 21:18:57.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 
 static struct resource iic_resources[] = {
@@ -329,3 +330,48 @@ void __init plat_mem_setup(void)
 {
 	/* TODO: Register Node 1 */
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
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(timers, ARRAY_SIZE(timers));
+}
+
