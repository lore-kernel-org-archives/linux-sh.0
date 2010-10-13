From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:17:45 +0000
Subject: [PATCH] sh: free-without-alloc fix for sh_mobile_lcdcfb
Message-Id: <20101013071745.19716.66656.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Without this fix the LCDC driver will try to free
framebuffer memory even though the allocation failed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/video/sh_mobile_lcdcfb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2010-10-07 18:36:45.000000000 +0900
@@ -1324,8 +1324,10 @@ static int sh_mobile_lcdc_remove(struct 
 		if (priv->ch[i].sglist)
 			vfree(priv->ch[i].sglist);
 
-		dma_free_coherent(&pdev->dev, info->fix.smem_len,
-				  info->screen_base, priv->ch[i].dma_handle);
+		if (info->screen_base)
+			dma_free_coherent(&pdev->dev, info->fix.smem_len,
+					  info->screen_base,
+					  priv->ch[i].dma_handle);
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 	}
