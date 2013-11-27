From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:30:32 +0000
Subject: [PATCH] v4l: sh_vou: Fix warnings due to improper casts and printk formats
Message-Id: <1385512232-10361-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org

Use the %zu printk specifier to print size_t variables, and cast
pointers to unsigned long instead of unsigned int where applicable. This
fixes warnings on platforms where pointers and/or dma_addr_t have a
different size than int.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/sh_vou.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index 4f30341..853a5f8 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -286,7 +286,7 @@ static int sh_vou_buf_prepare(struct videobuf_queue *vq,
 	vb->size = vb->height * bytes_per_line;
 	if (vb->baddr && vb->bsize < vb->size) {
 		/* User buffer too small */
-		dev_warn(vq->dev, "User buffer too small: [%u] @ %lx\n",
+		dev_warn(vq->dev, "User buffer too small: [%zu] @ %lx\n",
 			 vb->bsize, vb->baddr);
 		return -EINVAL;
 	}
@@ -302,9 +302,10 @@ static int sh_vou_buf_prepare(struct videobuf_queue *vq,
 	}
 
 	dev_dbg(vou_dev->v4l2_dev.dev,
-		"%s(): fmt #%d, %u bytes per line, phys 0x%x, type %d, state %d\n",
+		"%s(): fmt #%d, %u bytes per line, phys 0x%lx, type %d, state %d\n",
 		__func__, vou_dev->pix_idx, bytes_per_line,
-		videobuf_to_dma_contig(vb), vb->memory, vb->state);
+		(unsigned long)videobuf_to_dma_contig(vb), vb->memory,
+		vb->state);
 
 	return 0;
 }
-- 
1.8.3.2

