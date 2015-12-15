From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:05:36 +0000
Subject: [PATCH/RFC 03/10] iommu/ipmmu-vmsa: Write IMCTR twice
Message-Id: <20151215130536.13535.79372.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Write IMCTR both in the root device and the leaf node.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- 0014/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 14:11:05.210513000 +0900
@@ -268,6 +268,16 @@ static void ipmmu_ctx_write(struct ipmmu
 	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
+static void ipmmu_ctx_write2(struct ipmmu_vmsa_domain *domain, unsigned int reg,
+			     u32 data)
+{
+	if (domain->mmu != domain->root)
+		ipmmu_write(domain->mmu,
+			    domain->context_id * IM_CTX_SIZE + reg, data);
+
+	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
+}
+
 /* -----------------------------------------------------------------------------
  * TLB and microTLB Management
  */
@@ -294,7 +304,7 @@ static void ipmmu_tlb_invalidate(struct
 
 	reg = ipmmu_ctx_read(domain, IMCTR);
 	reg |= IMCTR_FLUSH;
-	ipmmu_ctx_write(domain, IMCTR, reg);
+	ipmmu_ctx_write2(domain, IMCTR, reg);
 
 	ipmmu_tlb_sync(domain);
 }
@@ -442,7 +452,8 @@ static int ipmmu_domain_init_context(str
 	 * software management as we have no use for it. Flush the TLB as
 	 * required when modifying the context registers.
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+	ipmmu_ctx_write2(domain, IMCTR,
+			 IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
 
 	return 0;
 }
@@ -457,7 +468,7 @@ static void ipmmu_domain_destroy_context
 	 *
 	 * TODO: Is TLB flush really needed ?
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
+	ipmmu_ctx_write2(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
 }
 
