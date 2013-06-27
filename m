From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:31 +0000
Subject: [PATCH 21/24] drm/rcar-du: Add support for DEFR8 register
Message-Id: <1372326574-4315-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The R8A7790 DU has a new extended function control register. Support it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 3 ++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   | 1 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 98e35aa..dd1950d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -217,7 +217,8 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_ALIGN_128B,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_ALIGN_128B
+		  | RCAR_DU_FEATURE_DEFR8,
 	.num_crtcs = 3,
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 160e5eb..70c335f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -27,6 +27,7 @@ struct rcar_du_device;
 
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock */
 #define RCAR_DU_FEATURE_ALIGN_128B	(1 << 1)	/* Align pitches to 128 bytes */
+#define RCAR_DU_FEATURE_DEFR8		(1 << 2)	/* Has DEFR8 register */
 
 /*
  * struct rcar_du_device_info - DU model-specific information
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 0eb106e..f3ba0ca 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -51,6 +51,8 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	rcar_du_group_write(rgrp, DEFR3, DEFR3_CODE | DEFR3_DEFE3);
 	rcar_du_group_write(rgrp, DEFR4, DEFR4_CODE);
 	rcar_du_group_write(rgrp, DEFR5, DEFR5_CODE | DEFR5_DEFE5);
+	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_DEFR8))
+		rcar_du_group_write(rgrp, DEFR8, DEFR8_CODE | DEFR8_DEFE8);
 
 	/* Use DS1PR and DS2PR to configure planes priorities and connects the
 	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
-- 
1.8.1.5

