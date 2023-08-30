Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A30DC83F1D
	for <linux-sh@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjH3SqS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242516AbjH3I6d (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 04:58:33 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 01:58:27 PDT
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E4CCB
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 01:58:27 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 5f5b1a34-2d76-4d17-87bc-3d5ae1674948;
        Wed, 30 Aug 2023 17:42:21 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 70A0E1C0372;
        Wed, 30 Aug 2023 17:42:21 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH 03/12] sh: SH4 OF support.
Date:   Wed, 30 Aug 2023 17:42:04 +0900
Message-Id: <4a138cf1ff14ff6166a66851db7476096fa3f009.1693384846.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693384846.git.ysato@users.sourceforge.jp>
References: <cover.1693384846.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- switch generic framework in clock / PCI.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/drivers/Makefile        |  2 ++
 arch/sh/include/asm/io.h        | 10 ++++++++++
 arch/sh/include/asm/pci.h       |  4 ++++
 arch/sh/kernel/cpu/Makefile     |  8 ++++++--
 arch/sh/kernel/cpu/clock.c      |  3 ++-
 arch/sh/kernel/cpu/sh4/Makefile |  2 ++
 6 files changed, 26 insertions(+), 3 deletions(-)

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
index d8f3537ef57f..d14adf034780 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -292,4 +292,14 @@ static inline void iounmap(volatile void __iomem *addr) { }
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
index 46118236bf04..e462a9552c92 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -16,6 +16,10 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 # Common interfaces.
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
+ifndef CONFIG_COMMON_CLK
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
-
-obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
+endif
+ifndef CONFIG_GENERIC_IRQ_CHIP
+obj-y	+= irq/
+endif
+obj-y	+= init.o clock.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 6fb34410d630..e6c75d4ba7e1 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -14,12 +14,13 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 
 int __init clk_init(void)
 {
-	int ret;
+	int ret = 0;
 
 #ifndef CONFIG_COMMON_CLK
 	ret = arch_clk_init();
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index 00c16331e07e..1e196c320b96 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -15,6 +15,7 @@ perf-$(CONFIG_CPU_SUBTYPE_SH7750)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7750S)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7091)	:= perf_event.o
 
+ifndef CONFIG_OF
 # CPU subtype setup
 obj-$(CONFIG_CPU_SUBTYPE_SH7750)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7750R)	+= setup-sh7750.o
@@ -32,6 +33,7 @@ endif
 
 # Additional clocks by subtype
 clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
+endif
 
 obj-y					+= $(clock-y)
 obj-$(CONFIG_PERF_EVENTS)		+= $(perf-y)
-- 
2.39.2

