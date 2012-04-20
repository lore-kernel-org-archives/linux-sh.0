From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 20 Apr 2012 16:59:55 +0000
Subject: [PATCH 3/5] mmc: sh_mmcif: remove unused .down_pwr() callback
Message-Id: <Pine.LNX.4.64.1204201839400.3974@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
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

