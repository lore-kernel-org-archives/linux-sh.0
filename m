From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:08 +0000
Subject: [PATCH 21/22] drm: rcar-du: lvds: Rename PLLEN bit to PLLON
Message-Id: <1442184669-30990-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The bit is named PLLON in the datasheet, rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 2 +-
 drivers/gpu/drm/rcar-du/rcar_lvds_regs.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
index e044a17a2a2f..02acebadf7d6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -102,7 +102,7 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 	/* Turn the PLL on, wait for the startup delay, and turn the output
 	 * on.
 	 */
-	lvdcr0 |= LVDCR0_PLLEN;
+	lvdcr0 |= LVDCR0_PLLON;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
 
 	usleep_range(100, 150);
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds_regs.h b/drivers/gpu/drm/rcar-du/rcar_lvds_regs.h
index 77cf9289ab65..b1eafd097a79 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds_regs.h
@@ -18,7 +18,7 @@
 #define LVDCR0_DMD			(1 << 12)
 #define LVDCR0_LVMD_MASK		(0xf << 8)
 #define LVDCR0_LVMD_SHIFT		8
-#define LVDCR0_PLLEN			(1 << 4)
+#define LVDCR0_PLLON			(1 << 4)
 #define LVDCR0_BEN			(1 << 2)
 #define LVDCR0_LVEN			(1 << 1)
 #define LVDCR0_LVRES			(1 << 0)
-- 
2.4.6

