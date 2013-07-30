From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 30 Jul 2013 10:37:32 +0000
Subject: [PATCH v2 08/13] mmc: sh_mmcif: Remove .down_pwr() callback from platform data
Message-Id: <1375180657-23641-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The callback isn't used by the driver and isn't initialized by board
code. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/sh_mmcif.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index e7d5dd6..39011eb 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -34,7 +34,6 @@
 
 struct sh_mmcif_plat_data {
 	void (*set_pwr)(struct platform_device *pdev, int state);
-	void (*down_pwr)(struct platform_device *pdev);
 	int (*get_cd)(struct platform_device *pdef);
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
-- 
1.8.1.5

