Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C2ECA551B
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbjIMJYL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjIMJYJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:09 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC261993
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 9cd12d4a-099e-4126-86b3-3d079cdc72da;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 68DAF1C01AA;
        Wed, 13 Sep 2023 18:24:02 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 03/30] arch/sh: Disable SH specific drivers in OF enabled.
Date:   Wed, 13 Sep 2023 18:23:28 +0900
Message-Id: <236185b4a47f303332aafeacadd9c9652e650062.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

OF uses a common framework.
Avoid using clk, irq and PCI SH-specific drivers.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Kconfig                 |  6 ++++--
 arch/sh/boards/of-generic.c     | 23 +++++++++--------------
 arch/sh/drivers/Makefile        |  2 ++
 arch/sh/include/asm/io.h        | 14 ++++++++++++--
 arch/sh/include/asm/pci.h       |  4 ++++
 arch/sh/kernel/cpu/Makefile     |  9 +++++++--
 arch/sh/kernel/cpu/sh4/Makefile |  2 ++
 arch/sh/kernel/time.c           |  7 ++++++-
 drivers/sh/Makefile             |  2 ++
 9 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 33530b044953..451595ef6f4f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -65,10 +65,10 @@ config SUPERH
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT
-	select NO_GENERIC_PCI_IOPORT_MAP if PCI
+	select NO_GENERIC_PCI_IOPORT_MAP if !SH_DEVICE_TREE
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND
-	select PCI_DOMAINS if PCI
+	select PCI_DOMAINS if PCI && !SH_DEVICE_TREE
 	select PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
@@ -379,6 +379,7 @@ config CPU_SUBTYPE_SH7751
 config CPU_SUBTYPE_SH7751R
 	bool "Support SH7751R processor"
 	select CPU_SH4
+	select PCI_SH7751 if SH_DEVICE_TREE
 
 config CPU_SUBTYPE_SH7760
 	bool "Support SH7760 processor"
@@ -527,6 +528,7 @@ config SH_PCLK_FREQ
 
 config SH_CLK_CPG
 	def_bool y
+	depends on !COMMON_CLK
 
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b..51ad68c280bb 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <asm/machvec.h>
@@ -107,7 +108,7 @@ static int noopi(void)
 	return 0;
 }
 
-static void __init sh_of_mem_reserve(void)
+static void __init sh_of_mem_init(void)
 {
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -116,6 +117,8 @@ static void __init sh_of_mem_reserve(void)
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
+	struct device_node *cpu;
+	int freq;
 
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
@@ -125,6 +128,9 @@ static void __init sh_of_setup(char **cmdline_p)
 	}
 
 	sh_of_smp_probe();
+	cpu = of_find_node_by_name(NULL, "cpu");
+	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
+		preset_lpj = freq / 500;
 }
 
 static int sh_of_irq_demux(int irq)
@@ -140,25 +146,14 @@ static void __init sh_of_init_irq(void)
 	irqchip_init();
 }
 
-static int __init sh_of_clk_init(void)
-{
-#ifdef CONFIG_COMMON_CLK
-	/* Disabled pending move to COMMON_CLK framework. */
-	pr_info("SH generic board support: scanning for clk providers\n");
-	of_clk_init(NULL);
-#endif
-	return 0;
-}
-
 static struct sh_machine_vector __initmv sh_of_generic_mv = {
 	.mv_setup	= sh_of_setup,
 	.mv_name	= "devicetree", /* replaced by DT root's model */
 	.mv_irq_demux	= sh_of_irq_demux,
 	.mv_init_irq	= sh_of_init_irq,
-	.mv_clk_init	= sh_of_clk_init,
+	.mv_clk_init	= noopi,
 	.mv_mode_pins	= noopi,
-	.mv_mem_init	= noop,
-	.mv_mem_reserve	= sh_of_mem_reserve,
+	.mv_mem_init	= sh_of_mem_init,
 };
 
 struct sh_clk_ops;
diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index 56b0acace6e7..eacbcefb26b2 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -5,7 +5,9 @@
 
 obj-y		+= dma/ platform_early.o
 
+ifndef CONFIG_SH_DEVICE_TREE
 obj-$(CONFIG_PCI)		+= pci/
+endif
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
 obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index f2f38e9d489a..3519eb6a9715 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -311,10 +311,20 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define xlate_dev_mem_ptr(p)	__va(p)
 #define unxlate_dev_mem_ptr(p, v) do { } while (0)
 
-#include <asm-generic/io.h>
-
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
+
+#ifdef __KERNEL__
+#define PCI_IOBASE	0xfe240000UL
+
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	PCI_IOBASE
+#define PIO_MASK	0x3ffffUL
+#define PIO_RESERVED	0x40000UL
+#endif /* __KERNEL__ */
+
+#include <asm-generic/io.h>
+
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 54c30126ea17..92b3bd604319 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PCI_H
 #define __ASM_SH_PCI_H
 
+#ifndef CONFIG_SH_DEVICE_TREE
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
@@ -88,4 +89,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	return hose->need_domain_info;
 }
 
+#else /* CONFIG_SH_DEVICE_TREE */
+#include <asm-generic/pci.h>
+#endif
 #endif /* __ASM_SH_PCI_H */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index 46118236bf04..e00ebf134985 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -16,6 +16,11 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 # Common interfaces.
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
+ifndef CONFIG_COMMON_CLK
+obj-y += clock.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
-
-obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
+endif
+ifndef CONFIG_GENERIC_IRQ_CHIP
+obj-y	+= irq/
+endif
+obj-y	+= init.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index 00c16331e07e..d8c3242c4a9f 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -15,6 +15,7 @@ perf-$(CONFIG_CPU_SUBTYPE_SH7750)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7750S)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7091)	:= perf_event.o
 
+ifndef CONFIG_SH_DEVICE_TREE
 # CPU subtype setup
 obj-$(CONFIG_CPU_SUBTYPE_SH7750)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7750R)	+= setup-sh7750.o
@@ -32,6 +33,7 @@ endif
 
 # Additional clocks by subtype
 clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
+endif # CONFIG_SH_DEVICE_TREE
 
 obj-y					+= $(clock-y)
 obj-$(CONFIG_PERF_EVENTS)		+= $(perf-y)
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 821a09cbd605..5911d7e8dfdb 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -19,6 +19,7 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 #include <asm/platform_early.h>
+#include <linux/of_clk.h>
 
 static void __init sh_late_time_init(void)
 {
@@ -39,7 +40,11 @@ void __init time_init(void)
 {
 	timer_probe();
 
+#ifndef CONFIG_SH_DEVICE_TREE
 	clk_init();
-
+#else
+	pr_info("SH generic board support: scanning for clk providers\n");
+	of_clk_init(NULL);
+#endif
 	late_time_init = sh_late_time_init;
 }
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index c53262835e85..9a3e126704aa 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -2,7 +2,9 @@
 #
 # Makefile for the SuperH specific drivers.
 #
+ifneq ($(CONFIG_SH_DEVICE_TREE),y)
 obj-$(CONFIG_SH_INTC)			+= intc/
+endif
 ifneq ($(CONFIG_COMMON_CLK),y)
 obj-$(CONFIG_HAVE_CLK)			+= clk/
 endif
-- 
2.39.2

