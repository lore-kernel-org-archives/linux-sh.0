From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:04 +0000
Subject: [PATCH 17/22] drm: rcar-du: Output the DISP signal on the ODDF pin
Message-Id: <1442184669-30990-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The ODDF signal, output by default on the ODDF pin, isn't used on any
board supported in the kernel. As the Gen3 Salvator-X board uses the
ODDF pin as a DISP signal, hardcode that configuration in the driver.

Use of the ODDF signal will be implemented later through proper DT-based
configuration of the DU pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_group.c | 12 ++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_regs.h  |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 0e2b46dce563..144d1e0a7a4a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -44,6 +44,16 @@ void rcar_du_group_write(struct rcar_du_group *rgrp, u32 reg, u32 data)
 	rcar_du_write(rgrp->dev, rgrp->mmio_offset + reg, data);
 }
 
+static void rcar_du_group_setup_pins(struct rcar_du_group *rgrp)
+{
+	u32 defr6 = DEFR6_CODE | DEFR6_ODPM12_DISP;
+
+	if (rgrp->num_crtcs > 1)
+		defr6 |= DEFR6_ODPM22_DISP;
+
+	rcar_du_group_write(rgrp, DEFR6, defr6);
+}
+
 static void rcar_du_group_setup_defr8(struct rcar_du_group *rgrp)
 {
 	u32 defr8 = DEFR8_CODE | DEFR8_DEFE8;
@@ -71,6 +81,8 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	rcar_du_group_write(rgrp, DEFR4, DEFR4_CODE);
 	rcar_du_group_write(rgrp, DEFR5, DEFR5_CODE | DEFR5_DEFE5);
 
+	rcar_du_group_setup_pins(rgrp);
+
 	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS)) {
 		rcar_du_group_setup_defr8(rgrp);
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 95add71a33c8..2ccb1a241fc4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -187,7 +187,7 @@
 
 #define DEFR6			0x000e8
 #define DEFR6_CODE		(0x7778 << 16)
-#define DEFR6_ODPM22_D2SMR	(0 << 10)
+#define DEFR6_ODPM22_DSMR	(0 << 10)
 #define DEFR6_ODPM22_DISP	(2 << 10)
 #define DEFR6_ODPM22_CDE	(3 << 10)
 #define DEFR6_ODPM22_MASK	(3 << 10)
-- 
2.4.6

