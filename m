From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2009 06:29:58 +0000
Subject: [PATCH] sh: CONFIG_SH_CLK_DISABLE_LEGACY V2
Message-Id: <20090521062958.31416.44670.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090520135502.7742.12748.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090520135502.7742.12748.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Invert legacy kconfig logic in clkfwk branch V2. Instead
of building clock-cpg.c if CONFIG_SH_CLK_CPG_LEGACY is set,
let CONFIG_SH_CLK_DISABLE_LEGACY be no by default and let
upgraded processors use select to disable the legacy code.
Always build clock-cpg.c but wrap legacy code in ifdefs to
only build if CONFIG_SH_CLK_DISABLE_LEGACY is set to no.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |    5 +++--
 arch/sh/kernel/cpu/Makefile    |    3 +--
 arch/sh/kernel/cpu/clock-cpg.c |    4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-21 14:52:36.000000000 +0900
@@ -398,6 +398,7 @@ config CPU_SUBTYPE_SH7785
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_CLK_DISABLE_LEGACY
 
 config CPU_SUBTYPE_SH7786
 	bool "Support SH7786 processor"
@@ -513,8 +514,8 @@ config SH_PCLK_FREQ
 	  This is necessary for determining the reference clock value on
 	  platforms lacking an RTC.
 
-config SH_CLK_CPG_LEGACY
-	def_bool y if !CPU_SUBTYPE_SH7785
+config SH_CLK_DISABLE_LEGACY
+	def_bool n
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0001/arch/sh/kernel/cpu/Makefile
+++ work/arch/sh/kernel/cpu/Makefile	2009-05-21 14:53:19.000000000 +0900
@@ -17,6 +17,5 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 
 obj-$(CONFIG_UBC_WAKEUP)	+= ubc.o
 obj-$(CONFIG_SH_ADC)		+= adc.o
-obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
-obj-y	+= irq/ init.o clock.o
+obj-y	+= irq/ init.o clock.o clock-cpg.o
--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-05-21 14:55:08.000000000 +0900
@@ -2,6 +2,8 @@
 #include <linux/compiler.h>
 #include <asm/clock.h>
 
+#ifndef CONFIG_SH_CLK_DISABLE_LEGACY
+
 static struct clk master_clk = {
 	.name		= "master_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -58,3 +60,5 @@ int __init __weak arch_clk_init(void)
 {
 	return cpg_clk_init();
 }
+
+#endif /* CONFIG_SH_CLK_DISABLE_LEGACY */
