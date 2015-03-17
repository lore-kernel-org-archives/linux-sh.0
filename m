From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Mar 2015 01:36:18 +0000
Subject: [PATCH] drm/rcar-du: Lager DU2 VGA hack
Message-Id: <20150317013618.3502.75273.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is a very short term hack that separates VGA and HDMI
on r8a7790 Lager. It does that by forcing VGA on DU2 and
keeping LVDS2 as DU0 and putting HDMI(LVDS1) to DU1 only.

The idea is that separating VGA@DU2 from HDMI@DU1/LVDS@DU0
should reduce the need to flicker. DU2 is independent from
DU1 and DU0 and the patch does improve the state since with
it applied changing the VGA mode does not affect HDMI at all.

It may make more sense to adjust the code to allocate the
planes in a better way to avoid flicker completely.

This patch needs to be reworked as it does not apply to -next,
it is posted only as proof of concept. Not for upstream merge.

Two random observations:

1) The dpad0_source bits in the current driver needs more work.
Unless I hard code "2" as index the setmode test image never
reaches the display, however fbcon works without it.

2) It looks like the LVDS quirk stuff only applies to DU0/DU1
and not to DU2. At least the colors look completely wrong if
the quirk is enabled when DU2 is used.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |    4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_group.c   |   14 ++++++--------
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c |    3 ++-
 3 files changed, 10 insertions(+), 11 deletions(-)

--- 0001/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_drv.c	2015-03-16 11:15:56.467702953 +0900
@@ -65,7 +65,7 @@ static const struct rcar_du_device_info
 		 * (currently unsupported) TCON output.
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(2) | BIT(1) | BIT(0),
+			.possible_crtcs = BIT(2),
 			.encoder_type = DRM_MODE_ENCODER_NONE,
 			.port = 0,
 		},
@@ -75,7 +75,7 @@ static const struct rcar_du_device_info
 			.port = 1,
 		},
 		[RCAR_DU_OUTPUT_LVDS1] = {
-			.possible_crtcs = BIT(2) | BIT(1),
+			.possible_crtcs = BIT(1),
 			.encoder_type = DRM_MODE_ENCODER_LVDS,
 			.port = 2,
 		},
--- 0001/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_group.c	2015-03-16 12:18:20.137689500 +0900
@@ -52,7 +52,7 @@ static void rcar_du_group_setup_defr8(st
 	 * routing to DPAD0
 	 */
 	if (rgrp->index = 0)
-		defr8 |= DEFR8_DRGBS_DU(rgrp->dev->dpad0_source);
+		defr8 |= DEFR8_DRGBS_DU(2/*rgrp->dev->dpad0_source*/);
 
 	rcar_du_group_write(rgrp, DEFR8, defr8);
 }
@@ -67,8 +67,6 @@ static void rcar_du_group_setup(struct r
 	rcar_du_group_write(rgrp, DEFR5, DEFR5_CODE | DEFR5_DEFE5);
 
 	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS)) {
-		rcar_du_group_setup_defr8(rgrp);
-
 		/* Configure input dot clock routing. We currently hardcode the
 		 * configuration to routing DOTCLKINn to DUn.
 		 */
@@ -80,11 +78,6 @@ static void rcar_du_group_setup(struct r
 				    DIDSR_PDCS_CLK(1, 0) |
 				    DIDSR_PDCS_CLK(0, 0));
 	}
-
-	/* Use DS1PR and DS2PR to configure planes priorities and connects the
-	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
-	 */
-	rcar_du_group_write(rgrp, DORCR, DORCR_PG1D_DS1 | DORCR_DPRS);
 }
 
 /*
@@ -194,6 +187,11 @@ int rcar_du_group_set_routing(struct rca
 	else
 		dorcr |= DORCR_PG2T | DORCR_DK2S | DORCR_PG2D_DS2;
 
+	/* Use DS1PR and DS2PR to configure planes priorities and connects the
+	 * superposition 0 to DU0 pins. DU1 pins are configured dynamically.
+	 */
+	dorcr |= DORCR_PG1D_DS1 | DORCR_DPRS;
+
 	rcar_du_group_write(rgrp, DORCR, dorcr);
 
 	return rcar_du_set_dpad0_routing(rgrp->dev);
--- 0001/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c	2015-03-16 12:23:25.807688401 +0900
@@ -78,7 +78,8 @@ static int rcar_du_lvdsenc_start(struct
 			LVDCTRCR_CTR2SEL_DISP | LVDCTRCR_CTR1SEL_VSYNC |
 			LVDCTRCR_CTR0SEL_HSYNC);
 
-	if (rcar_du_needs(lvds->dev, RCAR_DU_QUIRK_LVDS_LANES))
+	if (rcrtc->index != 2 &&
+	    rcar_du_needs(lvds->dev, RCAR_DU_QUIRK_LVDS_LANES))
 		lvdhcr = LVDCHCR_CHSEL_CH(0, 0) | LVDCHCR_CHSEL_CH(1, 3)
 		       | LVDCHCR_CHSEL_CH(2, 2) | LVDCHCR_CHSEL_CH(3, 1);
 	else
