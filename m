From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:05:46 +0000
Subject: [PATCH/RFC 04/10] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
Message-Id: <20151215130546.13535.13440.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow certain DT compat strings to opt-out of setting up
IMBUSCR. The default case is unchanged.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- 0016/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 14:18:20.730513000 +0900
@@ -34,6 +34,7 @@
 struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
+	bool setup_imbuscr;
 };
 
 struct ipmmu_vmsa_device {
@@ -435,10 +436,10 @@ static int ipmmu_domain_init_context(str
 	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
-	ipmmu_ctx_write(domain, IMBUSCR,
-			ipmmu_ctx_read(domain, IMBUSCR) &
-			~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
-
+	if (domain->root->features->setup_imbuscr)
+		ipmmu_ctx_write(domain, IMBUSCR,
+				ipmmu_ctx_read(domain, IMBUSCR) &
+				~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
 	/*
 	 * IMSTR
 	 * Clear all interrupt flags.
@@ -876,6 +877,7 @@ static void ipmmu_device_reset(struct ip
 static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
+	.setup_imbuscr = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
