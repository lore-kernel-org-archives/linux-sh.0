From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Fri, 16 Nov 2012 05:46:11 +0000
Subject: [PATCH 3/4] drivers: uio_dmem_genirq: Allow partial success when opening device
Message-Id: <1353044772-18803-4-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>

The uio device should not fail on open just because one memory allocation
fails. The device might export several regions, the failure of some of
which may or may not be a problem for the user space driver.  Failing
regions will remain unmapped, and successful regions will be mapped and
exported to user space.  Also deals with the case where failing to map
a region after successfully allocating others would not unmap the
successfully allocated regions before dying.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/uio/uio_dmem_genirq.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 7be8d04..bbdf925 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -62,8 +62,6 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 				(dma_addr_t *)&uiomem->addr, GFP_KERNEL);
 		if (!addr) {
 			uiomem->addr = DMEM_MAP_ERROR;
-			ret = -ENOMEM;
-			break;
 		}
 		priv->dmem_region_vaddr[dmem_region++] = addr;
 		++uiomem;
@@ -93,11 +91,13 @@ static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
 	while (!priv->refcnt && uiomem < &priv->uioinfo->mem[MAX_UIO_MAPS]) {
 		if (!uiomem->size)
 			break;
-
-		dma_free_coherent(&priv->pdev->dev, uiomem->size,
-				priv->dmem_region_vaddr[dmem_region++],
-				uiomem->addr);
+		if (priv->dmem_region_vaddr[dmem_region]) {
+			dma_free_coherent(&priv->pdev->dev, uiomem->size,
+					priv->dmem_region_vaddr[dmem_region],
+					uiomem->addr);
+		}
 		uiomem->addr = DMEM_MAP_ERROR;
+		++dmem_region;
 		++uiomem;
 	}
 
-- 
1.7.5.4

