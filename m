From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Fri, 16 Nov 2012 05:46:10 +0000
Subject: [PATCH 2/4] drivers: uio_dmem_genirq: Don't use DMA_ERROR_CODE to indicate unmapped regions
Message-Id: <1353044772-18803-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>

DMA_ERROR_CODE is not defined on all architectures and is architecture
specific.  Instead, use the constant, ~0 to indicate unmapped regions.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 Documentation/DocBook/uio-howto.tmpl |    2 +-
 drivers/uio/uio_dmem_genirq.c        |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/DocBook/uio-howto.tmpl b/Documentation/DocBook/uio-howto.tmpl
index fdbf86f..ddb05e9 100644
--- a/Documentation/DocBook/uio-howto.tmpl
+++ b/Documentation/DocBook/uio-howto.tmpl
@@ -771,7 +771,7 @@ framework to set up sysfs files for this region. Simply leave it alone.
 	<varname>/sys/class/uio/uioX/maps/mapY/*</varname>.
 	The dynmaic memory regions will be freed when the UIO device file is
 	closed. When no processes are holding the device file open, the address
-	returned to userspace is DMA_ERROR_CODE.
+	returned to userspace is ~0.
 	</para>
 </sect1>
 
diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index d8bbe07..7be8d04 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -29,6 +29,7 @@
 #include <linux/of_address.h>
 
 #define DRIVER_NAME "uio_dmem_genirq"
+#define DMEM_MAP_ERROR (~0)
 
 struct uio_dmem_genirq_platdata {
 	struct uio_info *uioinfo;
@@ -60,6 +61,7 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 		addr = dma_alloc_coherent(&priv->pdev->dev, uiomem->size,
 				(dma_addr_t *)&uiomem->addr, GFP_KERNEL);
 		if (!addr) {
+			uiomem->addr = DMEM_MAP_ERROR;
 			ret = -ENOMEM;
 			break;
 		}
@@ -95,7 +97,7 @@ static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
 		dma_free_coherent(&priv->pdev->dev, uiomem->size,
 				priv->dmem_region_vaddr[dmem_region++],
 				uiomem->addr);
-		uiomem->addr = DMA_ERROR_CODE;
+		uiomem->addr = DMEM_MAP_ERROR;
 		++uiomem;
 	}
 
@@ -238,7 +240,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 			break;
 		}
 		uiomem->memtype = UIO_MEM_PHYS;
-		uiomem->addr = DMA_ERROR_CODE;
+		uiomem->addr = DMEM_MAP_ERROR;
 		uiomem->size = pdata->dynamic_region_sizes[i];
 		++uiomem;
 	}
-- 
1.7.5.4

