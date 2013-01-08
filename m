From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 08 Jan 2013 10:24:03 +0000
Subject: [PATCH] drivers: uio_dmem_genirq: Add mmap support for dynamic regions
Message-Id: <1357640643-17713-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de, gregkh@linuxfoundation.org, horms@verge.net.au
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>

Dynamic regions allocated with dma_alloc_coherent() should use
dma_mmap_coherent() to perform memory mapping. Other regions
are simply ioremapped, the same way as in the uio subsystem base
implementation.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/uio/uio_dmem_genirq.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 252434c..7a047ad 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -144,6 +144,38 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	return 0;
 }
 
+static int uio_dmem_genirq_mmap(struct uio_info *info,
+				struct vm_area_struct *vma) {
+	struct uio_dmem_genirq_platdata *priv = info->priv;
+	struct uio_mem *uiomem;
+	int dmem_region = priv->dmem_region_start;
+	int mi = vma->vm_pgoff;
+
+	if (priv->uioinfo->mem[mi].memtype != UIO_MEM_PHYS)
+		return -EINVAL;
+
+	if (mi < MAX_UIO_MAPS) {
+		uiomem = &priv->uioinfo->mem[mi];
+		if (!uiomem->size)
+			return -EINVAL;
+
+		if (mi < dmem_region) {	/* phyiscal address */
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+			return remap_pfn_range(vma,
+				       vma->vm_start,
+				       uiomem->addr >> PAGE_SHIFT,
+				       vma->vm_end - vma->vm_start,
+				       vma->vm_page_prot);
+		} else {		/* DMA address */
+			vma->vm_pgoff = 0;
+			return dma_mmap_coherent(&priv->pdev->dev, vma,
+				priv->dmem_region_vaddr[mi],
+				uiomem->addr, uiomem->size);
+		}
+	}
+	return -EINVAL;
+}
+
 static int uio_dmem_genirq_probe(struct platform_device *pdev)
 {
 	struct uio_dmem_genirq_pdata *pdata = pdev->dev.platform_data;
@@ -263,6 +295,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	uioinfo->irqcontrol = uio_dmem_genirq_irqcontrol;
 	uioinfo->open = uio_dmem_genirq_open;
 	uioinfo->release = uio_dmem_genirq_release;
+	uioinfo->mmap = uio_dmem_genirq_mmap;
 	uioinfo->priv = priv;
 
 	/* Enable Runtime PM for this device:
-- 
1.7.5.4

