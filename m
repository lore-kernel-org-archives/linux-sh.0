From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:27:14 +0000
Subject: [PATCH 1/2] arch/sh: make l2_cache_init() return an integer
Message-Id: <20180326212715.12907-2-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On some SH platforms, enabling the L2 cache requires changing bits in
the CCR register. However, this register is already being changed by
the cache_init() function in arch/sh/kernel/cpu/init.c function, so
the l2_cache_init() function called by cache_init() cannot change CCR
as well.

In order to solve this, we change l2_cache_init() into a function that
returns a bit mask that will be OR'ed into the value written to the
CCR register by cache_init(). It won't support all possible
situations, but will be good enough to enable L2 on SH7786.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/kernel/cpu/init.c              | 4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 3 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index c4f01c5c8736..eb6775cdb9fc 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -99,7 +99,7 @@ static void expmask_init(void)
 #endif
 
 /* 2nd-level cache init */
-void __attribute__ ((weak)) l2_cache_init(void)
+int __attribute__ ((weak)) l2_cache_init(void)
 {
 }
 
@@ -187,7 +187,7 @@ static void cache_init(void)
 	flags &= ~CCR_CACHE_ENABLE;
 #endif
 
-	l2_cache_init();
+	flags |= l2_cache_init();
 
 	__raw_writel(flags, SH_CCR);
 	back_to_cached();
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 1c1b3c469831..c6c29206dee7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -421,10 +421,11 @@ void __init plat_early_device_setup(void)
 #define RAMCR_CACHE_L2E		0x0001
 #define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
 
-void l2_cache_init(void)
+int l2_cache_init(void)
 {
 	/* Enable L2 cache */
 	__raw_writel(L2_CACHE_ENABLE, RAMCR);
+	return 0;
 }
 
 enum {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index c20258b18775..ee9f5209adf0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -841,10 +841,11 @@ void __init plat_early_device_setup(void)
 #define RAMCR_CACHE_L2E		0x0001
 #define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
 
-void l2_cache_init(void)
+int l2_cache_init(void)
 {
 	/* Enable L2 cache */
 	__raw_writel(L2_CACHE_ENABLE, RAMCR);
+	return 0;
 }
 
 enum {
-- 
2.14.3

