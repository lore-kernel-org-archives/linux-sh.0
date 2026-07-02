Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFE348A2C2;
	Thu,  2 Jul 2026 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985095; cv=none; b=bo0Kgc/7Tw8oQQ4lPQ6Qwf4GWyfgkVSKV9/9hhuh2AjuLipTBpxZEdD/g6lOhnNZTNdfgCeDa4qmYfPGBPryhRAxCAkW1aUSq7r3PatYFFJE1sNYx/1RpPyFhZIOdMumXIxz7toa23yolDC8nIXspAg37u4A6m0Rm3bUa7O6+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985095; c=relaxed/simple;
	bh=epYonHdsCu3YirGGT12k5FJ3x+dKhIcoGp5T/BG0A1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrvxBKQTUag54dRFokFjA5f/rfXs5f437QyhsIveY57e7skU0E0wSxaPpLNAgK9MJ5S/NYTu/xXPmAkencReiPFfr+CmdaVq9TBdDYFrl/hYnk7LshmXyw48k3NxK07Ei0kNmF3iDoBa0fKOgVKHnWsxzMWHzKNw/AXr71paXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6/xmAOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6/xmAOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF89C1F000E9;
	Thu,  2 Jul 2026 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985094;
	bh=/Z6heYhi35fgtuRmKf8NxpNNlGv0sIxDmxjwD5twDRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k6/xmAOcT8rEsiao1u25sq+E07mVVfE00IwwTTaT8RSBShO0TEaSHxHgOljp+5zp+
	 uaWnj7i7/GlvHBChJ3E6lvA74ycgnkQErkWm9NEBc+LnsSgeCAdh2mcMqi9TY3pQqo
	 HebKRtx/JjQ8ESZGne7tlm43JoQhBe6MoSYiMUyES/ed5yyiqwzkm3gS9j8cvXPoKa
	 +f/Rh3wVkYvZjdLT5z3VxdTABM7TKiFnOC3V1SzBi1E1vFqIqWDyIuTBxkF/b/L3IA
	 u8qEx6fkBcgKSRzS4NVLtpthuWonBYT21nLbwAAS3YJhIOku+lhntQOl2Kmdh+LVOK
	 4iBlnR/WpdArQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:55 +0300
Subject: [PATCH v3 06/10] sh: drop include/asm/mmzone.h
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-6-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

include/asm/mmzone.h was required for declarations of NUMA related
functionality.

The only function declared there that's not related to NUMA is
__add_active_range().

Move __add_active_range() declaration to include/asm/setup.h and drop
include/asm/mmzone.h

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/include/asm/mmzone.h           | 42 ----------------------------------
 arch/sh/include/asm/setup.h            |  3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  1 -
 arch/sh/kernel/setup.c                 |  2 --
 arch/sh/mm/init.c                      |  1 -
 11 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/sh/include/asm/mmzone.h b/arch/sh/include/asm/mmzone.h
deleted file mode 100644
index 63f88b465e39..000000000000
--- a/arch/sh/include/asm/mmzone.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_MMZONE_H
-#define __ASM_SH_MMZONE_H
-
-#ifdef CONFIG_NUMA
-#include <linux/numa.h>
-
-static inline int pfn_to_nid(unsigned long pfn)
-{
-	int nid;
-
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
-		if (pfn >= node_start_pfn(nid) && pfn <= node_end_pfn(nid))
-			break;
-
-	return nid;
-}
-
-static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
-{
-	return NODE_DATA(pfn_to_nid(pfn));
-}
-
-/* arch/sh/mm/numa.c */
-void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end);
-#else
-static inline void
-setup_bootmem_node(int nid, unsigned long start, unsigned long end)
-{
-}
-#endif /* CONFIG_NUMA */
-
-/* Platform specific mem init */
-void __init plat_mem_setup(void);
-
-/* arch/sh/kernel/setup.c */
-void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
-			       unsigned long end_pfn);
-/* arch/sh/mm/init.c */
-void __init allocate_pgdat(unsigned int nid);
-
-#endif /* __ASM_SH_MMZONE_H */
diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index 8488f76b48b4..6762612f456c 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -24,4 +24,7 @@ void check_for_initrd(void);
 void per_cpu_trap_init(void);
 void sh_fdt_init(phys_addr_t dt_phys);
 
+void __add_active_range(unsigned int nid, unsigned long start_pfn,
+			unsigned long end_pfn);
+
 #endif /* _SH_SETUP_H */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 2180819a1455..5e2c24c518b4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -16,7 +16,6 @@
 #include <linux/usb/m66592.h>
 
 #include <asm/clock.h>
-#include <asm/mmzone.h>
 #include <asm/siu.h>
 #include <asm/platform_early.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index d64d28c4f059..5c24ff407c89 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -17,7 +17,6 @@
 
 #include <asm/cacheflush.h>
 #include <asm/clock.h>
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 #include <cpu/sh7723.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ef4b26a4b3d6..9441e4a0f402 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -24,7 +24,6 @@
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 #include <cpu/dma-register.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 1f4396da00e5..3750b598d6bd 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -21,7 +21,6 @@
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
 
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 static struct plat_sci_port scif2_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 95c3cc15a443..13f08c44fb02 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -13,7 +13,6 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 #include <cpu/dma-register.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index a46d6c3241a9..79484c598b83 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -22,7 +22,6 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <cpu/dma-register.h>
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index 3197ec2a65cd..93cdd1ee888d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -13,7 +13,6 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <cpu/shx3.h>
-#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 /*
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 5e25c1db4d61..2f2764061003 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -23,7 +23,6 @@
 #include <linux/smp.h>
 #include <linux/err.h>
 #include <linux/crash_dump.h>
-#include <linux/mmzone.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -41,7 +40,6 @@
 #include <asm/clock.h>
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
-#include <asm/mmzone.h>
 #include <asm/processor.h>
 #include <asm/sparsemem.h>
 #include <asm/platform_early.h>
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 1efc3104a9df..b337e6a259ed 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -20,7 +20,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <asm/mmu_context.h>
-#include <asm/mmzone.h>
 #include <asm/kexec.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>

-- 
2.53.0

