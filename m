From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 05 Mar 2013 09:59:40 +0000
Subject: [PATCH v3] shmobile: ipmmu: Add basic PMB support
Message-Id: <1362477580-28987-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PMB can be used to allow multimedia hardware to remap
physical memory from the 0x80000000-0xbfffffff address range to the
0x00000000-0x7fffffff range.  It also has the ability to perform
tiled-linear address translation, which can be used to access a memory
buffer as a series of n x m tiles, useful for image encoding/decoding.
Currently only the only access is via character device for use with user
space multimedia drivers.
All register access and hardware dependent functionality is
provided by the IPMMU driver, which is shared with the IOMMU/TLB module.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---

Hello all, 

Here is the much delayed v3 for this patch.  Just some minor updates to the
initialization code which I think should address Morimoto-san's comment.

Changes from v2:
----------------

* Assign PMB private data inside ipmmu_pmb_init() and change return val type to int
* Use devm_free to free private data on ipmmu_pmb_init() failure.
    It is necessary to free the memory explicitly in this case since the TLB side
    of the driver may continue operate, keeping the underyling dev active, even
    when the PMB initialization fails.

Changes from v1:
---------------

* Rebased onto latest (v6) shmobile IOMMU patch series 
* Correct locking to ensure thread safety in set_pmb() and set_pmb_tile()
* Disable PMB once last client has disconnected
* Move user space API header definition to /include/uapi/ directory
* Allocate driver private data with devm_kzmalloc()
* Use unsigned data types for PMB indices, memory sizes, etc.
* Simplify PMB handle allocation by using a lookup table
* Fix address range error in patch comment

 drivers/iommu/Kconfig             |   15 ++
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/shmobile-ipmmu.c    |  121 +++++++++++-
 drivers/iommu/shmobile-ipmmu.h    |   28 +++-
 drivers/iommu/shmobile-pmb.c      |  385 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/shmobile-pmb.h |   53 +++++
 6 files changed, 595 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/shmobile-pmb.c
 drivers/iommu/Kconfig             |   15 ++
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/shmobile-ipmmu.c    |  121 +++++++++++-
 drivers/iommu/shmobile-ipmmu.h    |   28 +++-
 drivers/iommu/shmobile-pmb.c      |  389 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/shmobile-pmb.h |   53 +++++
 6 files changed, 599 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iommu/shmobile-pmb.c
 create mode 100644 include/uapi/linux/shmobile-pmb.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 5c514d07..6fc3995 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -261,4 +261,19 @@ config SHMOBILE_IOMMU_L1SIZE
 	default 256 if SHMOBILE_IOMMU_ADDRSIZE_64MB
 	default 128 if SHMOBILE_IOMMU_ADDRSIZE_32MB
 
+config SHMOBILE_PMB
+	bool "IPMMU PMB driver"
+	default n
+	depends on (ARM && ARCH_SHMOBILE)
+	select SHMOBILE_IPMMU
+	help
+	  This enables the PMB interface of the IPMMU hardware module.
+	  The PMB can be used to remap 16, 64, 128 or 512 MiB pages from
+	  the 0x80000000-0xffffffff address range to anywhere in the
+	  0x00000000-0x7fffffff range.
+	  PMB support can be used either with or without SHMOBILE IOMMU
+	  support.
+
+	  If unsure, say N.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ef0e520..618238b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
+obj-$(CONFIG_SHMOBILE_PMB) += shmobile-pmb.o
diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 8321f89..be5c7c0 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -15,14 +15,37 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include "shmobile-ipmmu.h"
 
-#define IMCTR1 0x000
-#define IMCTR2 0x004
-#define IMASID 0x010
-#define IMTTBR 0x014
-#define IMTTBCR 0x018
+#define IMCTR1		0x00
+#define IMCTR1_TLBEN	(1 << 0)
+#define IMCTR1_FLUSH	(1 << 1)
+#define IMCTR2		0x04
+#define IMCTR2_PMBEN	0x01
+#define IMASID		0x010
+#define IMTTBR		0x014
+#define IMTTBCR		0x018
+#define IMPMBA_BASE	0x80
+#define IMPBMA_V	(1 << 8)
+#define IMPMBD_BASE	0xC0
+#define IMPBMD_V	(1 << 8)
+#define IMPBMD_SZ_16M	0x00
+#define IMPBMD_SZ_64M	0x10
+#define IMPBMD_SZ_128M	0x80
+#define IMPBMD_SZ_512M	0x90
+#define IMPBMD_BV	(1 << 9)
+#define IMPBMD_TBM_MASK	(7 << 12)
+#define IMPBMD_TBM_POS	12
+#define IMPBMD_HBM_MASK	(7 << 16)
+#define IMPBMD_HBM_POS	16
+#define IMPBMD_VBM_MASK	(7 << 20)
+#define IMPBMD_VBM_POS	20
 
-#define IMCTR1_TLBEN (1 << 0)
-#define IMCTR1_FLUSH (1 << 1)
+#define MIN_TILE_WIDTH	16
+#define MAX_TILE_WIDTH	2048
+#define MIN_TILE_HEIGHT 2
+#define MAX_TILE_HEIGHT 256
+
+#define IMPBMA(x) (IMPMBA_BASE + 0x4 * x)
+#define IMPBMD(x) (IMPMBD_BASE + 0x4 * x)
 
 static void ipmmu_reg_write(struct shmobile_ipmmu *ipmmu, unsigned long reg_off,
 			    unsigned long data)
@@ -88,6 +111,89 @@ void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 	mutex_unlock(&ipmmu->flush_lock);
 }
 
+void ipmmu_pmb_enable(struct shmobile_ipmmu *ipmmu,
+		      bool enable)
+{
+	ipmmu_reg_write(ipmmu, IMCTR2, enable ? IMCTR2_PMBEN : 0);
+
+}
+
+void ipmmu_pmb_set_addr(struct shmobile_ipmmu *ipmmu,
+		 unsigned int index,
+		 unsigned long addr,
+		 bool enabled)
+{
+	if (!enabled)
+		ipmmu_reg_write(ipmmu, IMPBMA(index), 0);
+	else
+		ipmmu_reg_write(ipmmu, IMPBMA(index), addr | IMPBMD_V);
+}
+
+int ipmmu_pmb_set_data(struct shmobile_ipmmu *ipmmu,
+		 unsigned int index,
+		 const struct ipmmu_pmb_info *info,
+		 const struct pmb_tile_info *tile)
+{
+	u32 vb, hb, tb;
+	u32 reg;
+
+	if (!info || !info->enabled) {
+		ipmmu_reg_write(ipmmu, IMPBMD(index), 0);
+		return 0;
+	}
+
+	reg = info->paddr;
+
+	switch (info->size_mb) {
+	case 16:
+		reg |= IMPBMD_SZ_16M;
+		break;
+	case 64:
+		reg |= IMPBMD_SZ_64M;
+		break;
+	case 128:
+		reg |= IMPBMD_SZ_128M;
+		break;
+	case 512:
+		reg |= IMPBMD_SZ_512M;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg |= IMPBMD_V;
+
+	if (!tile || !tile->enabled) {
+		ipmmu_reg_write(ipmmu, IMPBMD(index), reg);
+		ipmmu_tlb_flush(ipmmu);
+		return 0;
+	}
+
+	if (!is_power_of_2(tile->tile_width) ||
+	    !is_power_of_2(tile->tile_height) ||
+	    tile->buffer_pitch <= tile->tile_width)
+		return -EINVAL;
+
+	if ((tile->tile_width < MIN_TILE_WIDTH) ||
+	    (tile->tile_width > MAX_TILE_WIDTH) ||
+	    (tile->tile_height < MIN_TILE_HEIGHT) ||
+	    (tile->tile_height > MAX_TILE_HEIGHT))
+		return -EINVAL;
+
+	tb = ilog2(tile->tile_width);
+	vb = ilog2(tile->tile_height) - 1;
+	hb = ilog2(tile->buffer_pitch) - tb - 1;
+	tb -= 4;
+
+	reg |= (tb << IMPBMD_TBM_POS) & IMPBMD_TBM_MASK;
+	reg |= (vb << IMPBMD_VBM_POS) & IMPBMD_VBM_MASK;
+	reg |= (hb << IMPBMD_HBM_POS) & IMPBMD_HBM_MASK;
+	reg |= IMPBMD_BV;
+	ipmmu_reg_write(ipmmu, IMPBMD(index), reg);
+	ipmmu_tlb_flush(ipmmu);
+	return 0;
+}
+
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct shmobile_ipmmu *ipmmu;
@@ -118,6 +224,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	ipmmu_reg_write(ipmmu, IMCTR1, 0x0); /* disable TLB */
 	ipmmu_reg_write(ipmmu, IMCTR2, 0x0); /* disable PMB */
 	ipmmu_iommu_init(ipmmu);
+	ipmmu_pmb_init(ipmmu);
 	return 0;
 }
 
diff --git a/drivers/iommu/shmobile-ipmmu.h b/drivers/iommu/shmobile-ipmmu.h
index 4d53684..10bff557 100644
--- a/drivers/iommu/shmobile-ipmmu.h
+++ b/drivers/iommu/shmobile-ipmmu.h
@@ -7,6 +7,8 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <uapi/linux/shmobile-pmb.h>
+
 #ifndef __SHMOBILE_IPMMU_H__
 #define __SHMOBILE_IPMMU_H__
 
@@ -17,10 +19,12 @@ struct shmobile_ipmmu {
 	struct mutex flush_lock;
 	const char * const *dev_names;
 	unsigned int num_dev_names;
+	void *pmb_priv;
 };
 
-#ifdef CONFIG_SHMOBILE_IPMMU_TLB
 void ipmmu_tlb_flush(struct shmobile_ipmmu *ipmmu);
+
+#ifdef CONFIG_SHMOBILE_IPMMU_TLB
 void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 		   int asid);
 int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu);
@@ -31,4 +35,26 @@ static inline int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
 }
 #endif
 
+#ifdef CONFIG_SHMOBILE_PMB
+/* Access functions used by PMB device */
+/*void handle_free(struct device *dev, unsigned long handle, int size_mb);
+unsigned long handle_alloc(struct device *dev, int size_mb);*/
+void ipmmu_pmb_set_addr(struct shmobile_ipmmu *ipmmu,
+		unsigned int index, unsigned long addr,
+		bool enabled);
+int ipmmu_pmb_set_data(struct shmobile_ipmmu *ipmmu, unsigned int index,
+		const struct ipmmu_pmb_info *info,
+		const struct pmb_tile_info *tile);
+void ipmmu_pmb_enable(struct shmobile_ipmmu *ipmmu, bool enable);
+/* PMB initialization */
+int ipmmu_pmb_init(struct shmobile_ipmmu *ipmmu);
+void ipmmu_pmb_deinit(void *pmb_priv);
+#else
+static inline int ipmmu_pmb_init(struct device *dev)
+{
+	return -EINVAL;
+}
+static inline void ipmmu_pmb_deinit(void *pmb_priv) { }
+#endif
+
 #endif /* __SHMOBILE_IPMMU_H__ */
diff --git a/drivers/iommu/shmobile-pmb.c b/drivers/iommu/shmobile-pmb.c
new file mode 100644
index 0000000..e6edede
--- /dev/null
+++ b/drivers/iommu/shmobile-pmb.c
@@ -0,0 +1,389 @@
+/*
+ * IPMMU-PMB driver
+ * Copyright (C) 2012 Damian Hobson-Garcia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/cdev.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include "shmobile-ipmmu.h"
+
+#define PMB_DEVICE_NAME "pmb"
+
+#define PMB_NR 16
+/* the smallest size that can be reserverd in the pmb */
+#define PMB_GRANULARITY (16 << 20)
+#define PMB_START_ADDR	0x80000000
+#define PMB_SIZE	0x40000000
+#define NUM_BITS(x)	((x) / PMB_GRANULARITY)
+#define NR_BITMAPS	((NUM_BITS(PMB_SIZE) + BITS_PER_LONG - 1) \
+				>> ilog2(BITS_PER_LONG))
+
+struct ipmmu_pmb_data {
+	struct ipmmu_pmb_priv	*priv;
+	struct ipmmu_pmb_info	info;
+	struct pmb_tile_info	tile;
+	unsigned long		handle;
+	int			index;
+};
+
+struct ipmmu_pmb_priv {
+	struct shmobile_ipmmu	*ipmmu;
+	struct cdev		cdev;
+	struct class		*pmb_class;
+	dev_t			pmb_dev;
+	unsigned long		busy_pmbs;
+	struct mutex		pmb_lock;
+	struct ipmmu_pmb_data	pmbs[PMB_NR];
+	struct mutex		settings_lock;
+	unsigned long		alloc_bitmaps[NR_BITMAPS];
+	bool			pmb_enabled;
+};
+
+struct pmb_alignment {
+	unsigned int	size_mb;
+	unsigned long	alloc_mask;
+	unsigned long	align_mask;
+};
+
+static int valid_size(int size_mb)
+{
+	switch (size_mb) {
+	case 16:
+	case 64:
+	case 128:
+	case 512:
+		return 1;
+	}
+	return 0;
+
+}
+
+
+static const struct pmb_alignment pmb_align_table[] = {
+	{ 16,	0x1,		0x0},
+	{ 64,	0xf,		0xeeeeeeee},
+	{ 128,	0xff,		0xfefefefe},
+	{ 512,	0xffffffff,	0xfffffffe},
+};
+
+static const struct pmb_alignment *lookup_pmb_alignment(unsigned int size_mb)
+{
+	const struct pmb_alignment *pmb_align = NULL;
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pmb_align_table); i++) {
+		if (pmb_align_table[i].size_mb = size_mb) {
+			pmb_align = &pmb_align_table[i];
+			break;
+		}
+	}
+	return pmb_align;
+}
+
+/* alloc_handle_locked() and free_handle_locked() must be called
+   with the settings_lock held */
+static unsigned long alloc_handle_locked(struct ipmmu_pmb_priv *priv,
+				     int size_mb)
+{
+	int i;
+	int idx;
+	unsigned long tmp_bitmap;
+	const struct pmb_alignment *pmb_align;
+
+	if (!valid_size(size_mb))
+		return ~0UL;
+
+	pmb_align = lookup_pmb_alignment(size_mb);
+	if (!pmb_align)
+		return ~0UL;
+
+	for (i = 0; i < NR_BITMAPS; i++) {
+		tmp_bitmap = priv->alloc_bitmaps[i];
+		tmp_bitmap |= pmb_align->align_mask;
+		idx = 0;
+		while (idx < BITS_PER_LONG) {
+			idx = find_next_zero_bit(&tmp_bitmap, BITS_PER_LONG,
+					idx);
+			if (idx = BITS_PER_LONG)
+				break;
+
+			if (!((pmb_align->alloc_mask << idx) &
+						priv->alloc_bitmaps[i]))
+				break;
+			idx++;
+		}
+		if (idx < BITS_PER_LONG)
+			break;
+	}
+	if (i = NR_BITMAPS)
+		return ~0UL;
+
+	priv->alloc_bitmaps[i] |= (pmb_align->alloc_mask << idx);
+
+	return PMB_START_ADDR + (i * BITS_PER_LONG + idx) * PMB_GRANULARITY;
+}
+
+static void free_handle_locked(struct ipmmu_pmb_priv *priv,
+			unsigned long handle,
+			int size_mb)
+{
+	int idx;
+	unsigned long offset;
+	const struct pmb_alignment *pmb_align;
+
+	pmb_align = lookup_pmb_alignment(size_mb);
+	if (!pmb_align)
+		return;
+	offset = handle - PMB_START_ADDR;
+	offset /= PMB_GRANULARITY;
+	idx = offset & (BITS_PER_LONG - 1);
+	offset = offset / BITS_PER_LONG;
+	priv->alloc_bitmaps[offset] &= ~(pmb_align->alloc_mask << idx);
+}
+
+static long set_pmb(struct ipmmu_pmb_data *data,
+	    struct ipmmu_pmb_info *info)
+{
+	struct ipmmu_pmb_priv *priv = data->priv;
+	unsigned long data_mask;
+	long err;
+
+	if (!info->enabled) {
+		mutex_lock(&priv->settings_lock);
+		if (data->handle) {
+			free_handle_locked(priv, data->handle,
+					data->info.size_mb);
+			data->handle = 0;
+		}
+		data->info = *info;
+		ipmmu_pmb_set_data(priv->ipmmu, data->index, NULL, NULL);
+		ipmmu_pmb_set_addr(priv->ipmmu, data->index, 0, false);
+		ipmmu_tlb_flush(priv->ipmmu);
+		mutex_unlock(&priv->settings_lock);
+		return 0;
+	}
+
+	data_mask = (info->size_mb << 20) - 1;
+
+	if (info->paddr & data_mask)
+		return -EINVAL;
+
+	mutex_lock(&priv->settings_lock);
+	if (data->info.enabled) {
+		err = -EBUSY;
+		goto err_out;
+	}
+
+	data->handle = alloc_handle_locked(priv, info->size_mb);
+
+	if (data->handle = (~0UL)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	data->info = *info;
+
+	err = ipmmu_pmb_set_data(priv->ipmmu, data->index, &data->info,
+		&data->tile);
+	if (err < 0)
+		goto err_out;
+
+	ipmmu_pmb_set_addr(priv->ipmmu, data->index, data->handle, true);
+	mutex_unlock(&priv->settings_lock);
+
+	mutex_lock(&priv->pmb_lock);
+	if (!priv->pmb_enabled) {
+		ipmmu_pmb_enable(priv->ipmmu, true);
+		priv->pmb_enabled = true;
+	}
+	mutex_unlock(&priv->pmb_lock);
+
+	ipmmu_tlb_flush(priv->ipmmu);
+
+	return 0;
+
+err_out:
+	mutex_unlock(&priv->settings_lock);
+	return err;
+}
+
+static long set_tile(struct ipmmu_pmb_data *data,
+	    struct pmb_tile_info *tile)
+{
+	struct ipmmu_pmb_priv *priv = data->priv;
+	long ret;
+
+	mutex_lock(&priv->settings_lock);
+	ret = ipmmu_pmb_set_data(priv->ipmmu, data->index, &data->info,
+		tile);
+	if (!ret)
+		data->tile = *tile;
+	mutex_unlock(&priv->settings_lock);
+	return ret;
+}
+
+static int ipmmu_pmb_open(struct inode *inode, struct file *filp)
+{
+	struct ipmmu_pmb_priv *priv;
+	int idx;
+	priv = container_of(inode->i_cdev, struct ipmmu_pmb_priv,
+		cdev);
+
+	mutex_lock(&priv->pmb_lock);
+	idx = find_first_zero_bit(&priv->busy_pmbs, PMB_NR);
+	if (idx = PMB_NR) {
+		mutex_unlock(&priv->pmb_lock);
+		return -EBUSY;
+	}
+
+	__set_bit(idx, &priv->busy_pmbs);
+	mutex_unlock(&priv->pmb_lock);
+	filp->private_data = &priv->pmbs[idx];
+	return 0;
+}
+
+static int ipmmu_pmb_release(struct inode *inode, struct file *filp)
+{
+	struct ipmmu_pmb_data *pmb = filp->private_data;
+	struct ipmmu_pmb_priv *priv = pmb->priv;
+	if (pmb->info.enabled) {
+		pmb->info.enabled = 0;
+		set_pmb(pmb, &pmb->info);
+	}
+
+	mutex_lock(&priv->pmb_lock);
+	__clear_bit(pmb->index, &priv->busy_pmbs);
+	if (!priv->busy_pmbs) {
+		ipmmu_pmb_enable(priv->ipmmu, false);
+		priv->pmb_enabled = false;
+	}
+	mutex_unlock(&priv->pmb_lock);
+	return 0;
+}
+
+static long ipmmu_pmb_ioctl(struct file *filp, unsigned int cmd_in,
+		       unsigned long arg)
+{
+	struct ipmmu_pmb_data *pmb;
+	struct ipmmu_pmb_info user_set;
+	struct pmb_tile_info user_tile;
+	long ret = -EINVAL;
+	pmb = filp->private_data;
+	switch (cmd_in) {
+	case IPMMU_GET_PMB:
+		ret = copy_to_user((char *)arg, &pmb->info, sizeof(pmb->info));
+		break;
+	case IPMMU_SET_PMB:
+		ret = copy_from_user(&user_set, (char *)arg, sizeof(user_set));
+		if (ret)
+			break;
+		ret = set_pmb(pmb, &user_set);
+		break;
+	case IPMMU_GET_PMB_HANDLE:
+		ret = copy_to_user((char *)arg, &pmb->handle,
+			sizeof(pmb->handle));
+		break;
+	case IPMMU_GET_PMB_TL:
+		ret = copy_to_user((char *)arg, &pmb->tile, sizeof(pmb->tile));
+		break;
+	case IPMMU_SET_PMB_TL:
+		ret = copy_from_user(&user_tile, (char *)arg,
+			sizeof(user_tile));
+		if (ret)
+			break;
+		ret = set_tile(pmb, &user_tile);
+		break;
+	}
+	return ret;
+}
+
+static const struct file_operations ipmmu_pmb_fops = {
+	.owner = THIS_MODULE,
+	.open = ipmmu_pmb_open,
+	.release = ipmmu_pmb_release,
+	.unlocked_ioctl = ipmmu_pmb_ioctl,
+};
+
+void ipmmu_pmb_deinit(void *arg)
+{
+	struct ipmmu_pmb_priv *priv = arg;
+
+	if (!priv)
+		return;
+
+	cdev_del(&priv->cdev);
+	device_destroy(priv->pmb_class, priv->pmb_dev);
+	unregister_chrdev_region(priv->pmb_dev, 1);
+	class_destroy(priv->pmb_class);
+}
+
+int ipmmu_pmb_init(struct shmobile_ipmmu *ipmmu)
+{
+	int err = -ENOENT;
+	int i;
+	struct ipmmu_pmb_priv *priv;
+
+	priv = devm_kzalloc(ipmmu->dev, sizeof(struct ipmmu_pmb_priv),
+								GFP_KERNEL);
+	if (!priv) {
+		dev_err(ipmmu->dev, "cannot allocate device data\n");
+		return -ENOMEM;
+	}
+
+	priv->ipmmu = ipmmu;
+
+	mutex_init(&priv->pmb_lock);
+	mutex_init(&priv->settings_lock);
+
+	priv->pmb_class = class_create(THIS_MODULE, "ipmmu-pmb");
+	if (IS_ERR(priv->pmb_class)) {
+		err = PTR_ERR(priv->pmb_class);
+		goto free_priv;
+	}
+
+	err = alloc_chrdev_region(&priv->pmb_dev, 0, 1, PMB_DEVICE_NAME);
+	if (err) {
+		dev_err(ipmmu->dev, "cannot allocate device num\n");
+		goto destroy_class;
+	}
+
+	if (!device_create(priv->pmb_class, ipmmu->dev, priv->pmb_dev, priv,
+			"pmb"))
+		goto unregister_region;
+
+	cdev_init(&priv->cdev, &ipmmu_pmb_fops);
+	priv->cdev.owner = THIS_MODULE;
+	priv->cdev.ops = &ipmmu_pmb_fops;
+	err = cdev_add(&priv->cdev, priv->pmb_dev, 1);
+	if (err) {
+		dev_err(ipmmu->dev, "cannot add ipmmu_pmb device\n");
+		goto destroy_device;
+	}
+	for (i = 0; i < PMB_NR; i++) {
+		priv->pmbs[i].index = i;
+		priv->pmbs[i].priv = priv;
+	}
+
+	ipmmu->pmb_priv = priv;
+
+	return 0;
+
+destroy_device:
+	device_destroy(priv->pmb_class, priv->pmb_dev);
+unregister_region:
+	unregister_chrdev_region(priv->pmb_dev, 1);
+destroy_class:
+	class_destroy(priv->pmb_class);
+free_priv:
+	devm_kfree(ipmmu->dev, priv);
+	return err;
+}
diff --git a/include/uapi/linux/shmobile-pmb.h b/include/uapi/linux/shmobile-pmb.h
new file mode 100644
index 0000000..d80ddee
--- /dev/null
+++ b/include/uapi/linux/shmobile-pmb.h
@@ -0,0 +1,53 @@
+/* shmobile-pmb.h
+ *
+ * Copyright (C) 2013  Damian Hobson-Garcia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __LINUX_SHMOBILE_PMB_H__
+#define __LINUX_SHMOBILE_PMB_H__
+
+/** SH-Mobile PMB user space API
+  *
+  * There are multiple PMBs available for use by the connected
+  * multimedia blocks.  Opening the device file will accociate
+  * one PMB with the file descriptor.  All PMB settings will be
+  * invalidated when the file descriptor is closed.  If no
+  * PMBs are available when an attempt to open the device file
+  * is opened, -EBUSY will be returned */
+
+struct ipmmu_pmb_info {
+	int		enabled;
+	unsigned long	paddr;
+	unsigned int    size_mb;
+};
+
+struct pmb_tile_info {
+	unsigned int	tile_width;
+	unsigned int	tile_height;
+	unsigned int	buffer_pitch;
+	int		enabled;
+};
+
+/* IOCTL commands.*/
+
+/** IPMMU_SET_PMB/IPMU_GET_PMB
+  * Set (or get) the physical address and size of the memory area to create
+  * a mapping to. The mapping will be automatically destroyted when the
+  * file descriptor is closed.
+  */
+#define IPMMU_SET_PMB		_IOW('S', 37, struct ipmmu_pmb_phys *)
+#define IPMMU_GET_PMB		_IOR('S', 38, struct ipmmu_pmb_phys *)
+/** IPMMU_GET_PMB_HANDLE
+  * Retrieve a handle to access a PMB from an IP block
+  */
+#define IPMMU_GET_PMB_HANDLE	_IOR('S', 39, unsigned long *)
+
+/** IPMMU_SET_PMB_TL/IPMU_GET_PMB_TL
+  * Set (or get) the tiled linear conversion settings for a PMB */
+#define IPMMU_SET_PMB_TL	_IOW('S', 41, struct ipmmu_pmb_tile_info *)
+#define IPMMU_GET_PMB_TL	_IOR('S', 42, struct ipmmu_pmb_tile_info *)
+
+#endif /* __LINUX_SHMOBILE_PMB_H__ */
-- 
1.7.5.4

