Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95AC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjKNIA4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjKNIAz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:55 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6BCC19E
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:51 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 248191C0497;
        Tue, 14 Nov 2023 17:00:51 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 10/37] sh: Common PCI framework support
Date:   Tue, 14 Nov 2023 17:00:01 +0900
Message-Id: <65b5ddcbecfa05088b3889d0815588012dc816da.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

When CONFIG_OF=y, a common PCI framework is used.
The new driver also needs to reference PCI headers, so move the
necessary header files to a public location rather than a private one.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/io.h                      | 40 +++++++++++++------
 .../sh/{drivers/pci => include/asm}/pci-sh4.h |  7 ++--
 .../{drivers/pci => include/asm}/pci-sh7751.h |  0
 .../{drivers/pci => include/asm}/pci-sh7780.h |  0
 arch/sh/include/asm/pci.h                     |  4 ++
 5 files changed, 36 insertions(+), 15 deletions(-)
 rename arch/sh/{drivers/pci => include/asm}/pci-sh4.h (99%)
 rename arch/sh/{drivers/pci => include/asm}/pci-sh7751.h (100%)
 rename arch/sh/{drivers/pci => include/asm}/pci-sh7780.h (100%)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index ac521f287fa5..ef9b774dd4c8 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -150,6 +150,7 @@ __BUILD_MEMORY_STRING(__raw_, q, u64)
  */
 #undef CONF_SLOWDOWN_IO
 
+#ifndef CONFIG_GENERIC_IOMAP
 /*
  * On SuperH I/O ports are memory mapped, so we access them using normal
  * load/store instructions. sh_io_port_base is the virtual address to
@@ -163,11 +164,7 @@ static inline void __set_io_port_base(unsigned long pbase)
 	barrier();
 }
 
-#ifdef CONFIG_GENERIC_IOMAP
-#define __ioport_map ioport_map
-#else
 extern void __iomem *__ioport_map(unsigned long addr, unsigned int size);
-#endif
 
 #ifdef CONF_SLOWDOWN_IO
 #define SLOW_DOWN_IO __raw_readw(sh_io_port_base)
@@ -239,12 +236,6 @@ __BUILD_IOPORT_STRING(w, u16)
 __BUILD_IOPORT_STRING(l, u32)
 __BUILD_IOPORT_STRING(q, u64)
 
-#else /* !CONFIG_HAS_IOPORT_MAP */
-
-#include <asm/io_noioport.h>
-
-#endif
-
 #define inb(addr)      inb(addr)
 #define inw(addr)      inw(addr)
 #define inl(addr)      inl(addr)
@@ -265,6 +256,21 @@ __BUILD_IOPORT_STRING(q, u64)
 #define outsb outsb
 #define outsw outsw
 #define outsl outsl
+#else /* !CONFIG_GENERIC_IOMAP */
+#define __ioport_map ioport_map
+#endif
+
+#else /* !CONFIG_HAS_IOPORT_MAP */
+
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+#include <asm/io_noioport.h>
+
+#endif
 
 #define IO_SPACE_LIMIT 0xffffffff
 
@@ -311,10 +317,20 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define xlate_dev_mem_ptr(p)	__va(p)
 #define unxlate_dev_mem_ptr(p, v) do { } while (0)
 
-#include <asm-generic/io.h>
-
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
+
+#ifdef __KERNEL__
+#define PCI_IOBASE	((void __iomem *)0xfe240000UL)
+
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	0xfe240000UL
+#define PIO_MASK	0x3ffffUL
+#define PIO_RESERVED	0x40000UL
+#endif /* __KERNEL__ */
+
+#include <asm-generic/io.h>
+
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/drivers/pci/pci-sh4.h b/arch/sh/include/asm/pci-sh4.h
similarity index 99%
rename from arch/sh/drivers/pci/pci-sh4.h
rename to arch/sh/include/asm/pci-sh4.h
index 1543c50b6503..26a75841fbe2 100644
--- a/arch/sh/drivers/pci/pci-sh4.h
+++ b/arch/sh/include/asm/pci-sh4.h
@@ -5,9 +5,9 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785) || \
     defined(CONFIG_CPU_SUBTYPE_SH7763)
-#include "pci-sh7780.h"
+#include <asm/pci-sh7780.h>
 #else
-#include "pci-sh7751.h"
+#include <asm/pci-sh7751.h>
 #endif
 
 #include <asm/io.h>
@@ -153,6 +153,7 @@
   #define SH4_PCIPDTR_PB0	  0x000000001	/* Port 0 Enable */
 #define SH4_PCIPDR		0x220		/* Port IO Data Register */
 
+#ifndef CONFIG_PCI_HOST_COMMON
 /* arch/sh/kernel/drivers/pci/ops-sh4.c */
 extern struct pci_ops sh4_pci_ops;
 int pci_fixup_pcic(struct pci_channel *chan);
@@ -178,5 +179,5 @@ static inline unsigned long pci_read_reg(struct pci_channel *chan,
 {
 	return __raw_readl(chan->reg_base + reg);
 }
-
+#endif
 #endif /* __PCI_SH4_H */
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/include/asm/pci-sh7751.h
similarity index 100%
rename from arch/sh/drivers/pci/pci-sh7751.h
rename to arch/sh/include/asm/pci-sh7751.h
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/include/asm/pci-sh7780.h
similarity index 100%
rename from arch/sh/drivers/pci/pci-sh7780.h
rename to arch/sh/include/asm/pci-sh7780.h
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
-- 
2.39.2

