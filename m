From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:32 +0000
Subject: [PATCH 03/29] mmc: sh_mmcif: remove unused .down_pwr() callback
Message-Id: <1336057558-11031-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, hold this patch back, until

[PATCH 02/29] sh: ecovec: remove unused .down_pwr() MMCIF callback

is committed.

 include/linux/mmc/sh_mmcif.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 05f0e3d..cb84340 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -39,7 +39,6 @@ struct sh_mmcif_dma {
 
 struct sh_mmcif_plat_data {
 	void (*set_pwr)(struct platform_device *pdev, int state);
-	void (*down_pwr)(struct platform_device *pdev);
 	int (*get_cd)(struct platform_device *pdef);
 	struct sh_mmcif_dma	*dma;		/* Deprecated. Instead */
 	unsigned int		slave_id_tx;	/* use embedded slave_id_[tr]x */
-- 
1.7.2.5

