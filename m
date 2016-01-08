From: "=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>
Date: Fri, 08 Jan 2016 08:23:03 +0000
Subject: [RFC 1/4] iommu: add function iommu_min_pgsize
Message-Id: <1452241386-22830-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This function is useful for drivers wishing to learn about the minimum
supported page size of the IOMMU. This information can for example be
used by drivers to align memory addresses it wish to map into its iommu
domain.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/linux/iommu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f28dff3..53d7e69 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -317,6 +317,11 @@ static inline size_t iommu_map_sg(struct iommu_domain =
*domain,
 	return domain->ops->map_sg(domain, iova, sg, nents, prot);
 }
=20
+static inline size_t iommu_min_pgsize(struct iommu_domain *domain)
+{
+	return 1 << __ffs(domain->ops->pgsize_bitmap);
+}
+
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
@@ -386,6 +391,11 @@ static inline size_t iommu_map_sg(struct iommu_domain =
*domain,
 	return -ENODEV;
 }
=20
+static inline size_t iommu_min_pgsize(struct iommu_domain *domain)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
 					     u64 size, int prot)
--=20
2.6.4

