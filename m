From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:05:55 +0000
Subject: [PATCH/RFC 05/10] iommu/ipmmu-vmsa: Allow two bit SL0
Message-Id: <20151215130555.13535.39164.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce support for two bit SL0 bitfield in IMTTBCR
by using a separate feature flag.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- 0014/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 21:17:55.110513000 +0900
@@ -35,6 +35,7 @@ struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
 	bool setup_imbuscr;
+	bool twobit_imttbcr_sl0;
 };
 
 struct ipmmu_vmsa_device {
@@ -139,6 +140,10 @@ static struct ipmmu_vmsa_domain *to_vmsa
 #define IMTTBCR_TSZ0_MASK		(7 << 0)
 #define IMTTBCR_TSZ0_SHIFT		O
 
+#define IMTTBCR_SL0_TWOBIT_LVL_3	(0 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_2	(1 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)
+
 #define IMBUSCR				0x000c
 #define IMBUSCR_DVM			(1 << 2)
 #define IMBUSCR_BUSSEL_SYS		(0 << 0)
@@ -377,6 +382,7 @@ static struct iommu_gather_ops ipmmu_gat
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	phys_addr_t ttbr;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -428,9 +434,15 @@ static int ipmmu_domain_init_context(str
 	 * We use long descriptors with inner-shareable WBWA tables and allocate
 	 * the whole 32-bit VA space to TTBR0.
 	 */
+
+	if (domain->root->features->twobit_imttbcr_sl0)
+		tmp = IMTTBCR_SL0_TWOBIT_LVL_1;
+	else
+		tmp = IMTTBCR_SL0_LVL_1;
+
 	ipmmu_ctx_write(domain, IMTTBCR, IMTTBCR_EAE |
 			IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
-			IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
+			IMTTBCR_IRGN0_WB_WA | tmp);
 
 	/* MAIR0 */
 	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
@@ -878,6 +890,7 @@ static const struct ipmmu_features ipmmu
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
 	.setup_imbuscr = true,
+	.twobit_imttbcr_sl0 = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
