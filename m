Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFBCC46CA1
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjJNOyW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjJNOyV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:21 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631AD9
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:18 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 7a5778dd-67e6-4691-86d4-aa2bee418c6c;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 3CB431C03BE;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 08/35] arch/sh/include/asm: Disable SH specific PCI define in OF enabled.
Date:   Sat, 14 Oct 2023 23:53:43 +0900
Message-Id: <65515e3b6747597d611bf9f7d60f6b8f1034a5b9.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

For OF support, the PCI driver will be migrated to a common one.
Switch PCI-related headers to the common version.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/io.h  | 14 ++++++++++++--
 arch/sh/include/asm/pci.h |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

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
-- 
2.39.2

