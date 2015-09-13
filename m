From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:02 +0000
Subject: [PATCH 15/22] drm: rcar-du: Support up to 4 CRTCs
Message-Id: <1442184669-30990-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The Gen3 R8A7795 DU has 4 CRTCs, support them all.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index b63bdd12609e..9f0d94b3ec10 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -600,7 +600,7 @@ static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
 int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 {
 	static const unsigned int mmio_offsets[] = {
-		DU0_REG_OFFSET, DU1_REG_OFFSET, DU2_REG_OFFSET
+		DU0_REG_OFFSET, DU1_REG_OFFSET, DU2_REG_OFFSET, DU3_REG_OFFSET
 	};
 
 	struct rcar_du_device *rcdu = rgrp->dev;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index a81eb3281e7f..ce359edc9ab9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -67,7 +67,7 @@ struct rcar_du_device_info {
 	unsigned int num_lvds;
 };
 
-#define RCAR_DU_MAX_CRTCS		3
+#define RCAR_DU_MAX_CRTCS		4
 #define RCAR_DU_MAX_GROUPS		DIV_ROUND_UP(RCAR_DU_MAX_CRTCS, 2)
 #define RCAR_DU_MAX_LVDS		2
 #define RCAR_DU_MAX_VSPS		4
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index ac9c3e511e79..95add71a33c8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -16,6 +16,7 @@
 #define DU0_REG_OFFSET		0x00000
 #define DU1_REG_OFFSET		0x30000
 #define DU2_REG_OFFSET		0x40000
+#define DU3_REG_OFFSET		0x70000
 
 /* -----------------------------------------------------------------------------
  * Display Control Registers
-- 
2.4.6

