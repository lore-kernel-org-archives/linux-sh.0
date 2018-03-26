From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:27:15 +0000
Subject: [PATCH 2/2] arch/sh: enable L2 cache on SH7786
Message-Id: <20180326212715.12907-3-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This brings a significant performance improvement in some specific
scenarios, so let's enable the L2 cache.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/include/cpu-sh4/cpu/cache.h    | 2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 92c4cd119b66..6765e18ac6a5 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -22,10 +22,12 @@
 #define CCR_CACHE_WT	0x0002	/* Write-Through (for P0,U0,P3) (else writeback)*/
 #define CCR_CACHE_CB	0x0004	/* Copy-Back (for P1) (else writethrough) */
 #define CCR_CACHE_OCI	0x0008	/* OC Invalidate */
+#define CCR_CACHE_L2OE	0x0010  /* Operand Secondary Cache Enable */
 #define CCR_CACHE_ORA	0x0020	/* OC RAM Mode */
 #define CCR_CACHE_OIX	0x0080	/* OC Index Enable */
 #define CCR_CACHE_ICE	0x0100	/* Instruction Cache Enable */
 #define CCR_CACHE_ICI	0x0800	/* IC Invalidate */
+#define CCR_CACHE_L2IE	0x1000  /* Instruction Secondary Cache Enable */
 #define CCR_CACHE_IIX	0x8000	/* IC Index Enable */
 #ifndef CONFIG_CPU_SH4A
 #define CCR_CACHE_EMODE	0x80000000	/* EMODE Enable */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 17aac38a6e90..63fb246e23a9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -27,6 +27,8 @@
 #include <cpu/dma-register.h>
 #include <asm/mmzone.h>
 
+#include <asm/cache.h>
+
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
 	.type		= PORT_SCIF,
@@ -840,3 +842,8 @@ void __init plat_early_device_setup(void)
 	early_platform_add_devices(sh7786_early_devices,
 				   ARRAY_SIZE(sh7786_early_devices));
 }
+
+int l2_cache_init(void)
+{
+	return CCR_CACHE_L2OE | CCR_CACHE_L2IE;
+}
-- 
2.14.3

