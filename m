From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:06:23 +0000
Subject: [PATCH/RFC 08/10] iommu/ipmmu-vmsa: Break out domain allocation code
Message-Id: <20151215130623.13535.43116.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Break out the domain allocation code into a separate function.
This is preparation for future code sharing.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- 0014/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-14 19:23:22.210513000 +0900
@@ -457,13 +457,10 @@ static irqreturn_t ipmmu_domain_irq(int
  * IOMMU Operations
  */
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
@@ -473,6 +470,14 @@ static struct iommu_domain *ipmmu_domain
 	return &domain->io_domain;
 }
 
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+{
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	return __ipmmu_domain_alloc(type);
+}
+
 static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
