From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Oct 2009 01:20:06 +0000
Subject: [PATCH] sh: disabled cache handling fix for sh4
Message-Id: <20091016012006.20892.67821.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to handle the cache disabled case for sh4. Fixes breakage
introduced by 37443ef3f0406e855e169c87ae3f4ffb4b6ff635. Without
this patch configuring caches off with CONFIG_CACHE_OFF=y makes
kfr2r09 and migo-r lock up in fbdev deferred io or early user space.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 2.6.32 material

 arch/sh/mm/cache-sh4.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index a98c7d8..c1615d8 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -709,6 +709,7 @@ extern void __weak sh4__flush_region_init(void);
  */
 void __init sh4_cache_init(void)
 {
+	unsigned int cache_enabled = !!(__raw_readl(CCR) & CCR_CACHE_ENABLE);
 	unsigned int wt_enabled = !!(__raw_readl(CCR) & CCR_CACHE_WT);
 
 	printk("PVR=%08x CVR=%08x PRR=%08x\n",
@@ -716,6 +717,17 @@ void __init sh4_cache_init(void)
 		ctrl_inl(CCN_CVR),
 		ctrl_inl(CCN_PRR));
 
+	/* disabled cache handling:
+	 *
+	 * __flush_dcache_segment_fn() implementations in this file make use
+	 * of the movca instruction which bombs out if caches are disabled.
+	 *
+	 * no flushing is necessary in the disabled cache case so we can
+	 * just keep the noop functions in local_flush_..() and __flush_..()
+	 */
+	if (!cache_enabled)
+		return;
+
 	if (wt_enabled)
 		__flush_dcache_segment_fn = __flush_dcache_segment_writethrough;
 	else {
