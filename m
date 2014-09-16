From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 11:20:22 +0000
Subject: [PATCH 02/03] iommu/ipmmu-vmsa: Create mapping via group notifier
Message-Id: <20140916112022.14889.48320.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the IPMMU-VMSA driver to use a notifier
together with IOMMU groups to hook in all devices
in the same IOMMU group to the same IOMMU.

This patch introduces an assumption that all devices
in one IOMMU group share the same UTLB number.

Tested with USB Host 2.0 on r8a7790 Lager.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |  121 +++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 46 deletions(-)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2014-09-16 16:52:21.000000000 +0900
@@ -33,6 +33,7 @@ struct ipmmu_vmsa_device {
 	unsigned int num_utlbs;
 
 	struct dma_iommu_mapping *mapping;
+	struct notifier_block group_notifier;
 };
 
 struct ipmmu_vmsa_domain {
@@ -1013,9 +1014,79 @@ static int ipmmu_find_utlb(struct ipmmu_
 	return -1;
 }
 
-static int ipmmu_add_device(struct device *dev)
+static int ipmmu_add_device_mapping(struct device *dev,
+				    struct ipmmu_vmsa_device *mmu,
+				    int utlb)
 {
 	struct ipmmu_vmsa_archdata *archdata;
+	int ret;
+
+	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
+	if (!archdata)
+		return -ENOMEM;
+
+	archdata->mmu = mmu;
+	archdata->utlb = utlb;
+	dev->archdata.iommu = archdata;
+
+	/*
+	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
+	 * VAs. This will allocate a corresponding IOMMU domain.
+	 *
+	 * TODO:
+	 * - Create one mapping per context (TLB).
+	 * - Make the mapping size configurable ? We currently use a 2GB mapping
+	 *   at a 1GB offset to ensure that NULL VAs will fault.
+	 */
+	if (!mmu->mapping) {
+		struct dma_iommu_mapping *mapping;
+
+		mapping = arm_iommu_create_mapping(&platform_bus_type,
+						   SZ_1G, SZ_2G);
+		if (IS_ERR(mapping)) {
+			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
+			return PTR_ERR(mapping);
+		}
+
+		mmu->mapping = mapping;
+	}
+
+	/* Attach the ARM VA mapping to the device. */
+	ret = arm_iommu_attach_device(dev, mmu->mapping);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach device to VA mapping\n");
+		goto error;
+	}
+	return 0;
+
+error:
+	kfree(archdata);
+	dev->archdata.iommu = NULL;
+	return ret;
+}
+
+static int ipmmu_group_notify(struct notifier_block *nb,
+			      unsigned long action, void *data)
+{
+	struct ipmmu_vmsa_device *mmu;
+	struct device *dev = data;
+	struct iommu_group *group = iommu_group_get(dev);
+	int utlb = (int)iommu_group_get_iommudata(group);
+
+	mmu = container_of(nb, struct ipmmu_vmsa_device, group_notifier);
+
+	/* TODO: remove device */
+	switch (action) {
+	case IOMMU_GROUP_NOTIFY_ADD_DEVICE:
+		ipmmu_add_device_mapping(dev, mmu, utlb);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ipmmu_add_device(struct device *dev)
+{
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_group *group;
 	int utlb = -1;
@@ -1056,6 +1127,8 @@ static int ipmmu_add_device(struct devic
 		return PTR_ERR(group);
 	}
 
+	iommu_group_set_iommudata(group, (void *)utlb, NULL);
+	iommu_group_register_notifier(group, &mmu->group_notifier);
 	ret = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
 
@@ -1064,51 +1137,6 @@ static int ipmmu_add_device(struct devic
 		return ret;
 	}
 
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	archdata->mmu = mmu;
-	archdata->utlb = utlb;
-	dev->archdata.iommu = archdata;
-
-	/*
-	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
-	 * VAs. This will allocate a corresponding IOMMU domain.
-	 *
-	 * TODO:
-	 * - Create one mapping per context (TLB).
-	 * - Make the mapping size configurable ? We currently use a 2GB mapping
-	 *   at a 1GB offset to ensure that NULL VAs will fault.
-	 */
-	if (!mmu->mapping) {
-		struct dma_iommu_mapping *mapping;
-
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   SZ_1G, SZ_2G);
-		if (IS_ERR(mapping)) {
-			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			return PTR_ERR(mapping);
-		}
-
-		mmu->mapping = mapping;
-	}
-
-	/* Attach the ARM VA mapping to the device. */
-	ret = arm_iommu_attach_device(dev, mmu->mapping);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach device to VA mapping\n");
-		goto error;
-	}
-
-	return 0;
-
-error:
-	kfree(dev->archdata.iommu);
-	dev->archdata.iommu = NULL;
-	iommu_group_remove_device(dev);
 	return ret;
 }
 
@@ -1167,6 +1195,7 @@ static int ipmmu_probe(struct platform_d
 	mmu->dev = &pdev->dev;
 	mmu->pdata = pdev->dev.platform_data;
 	mmu->num_utlbs = 32;
+	mmu->group_notifier.notifier_call = ipmmu_group_notify;
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
