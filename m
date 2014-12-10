From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:06 +0000
Subject: [PATCH 06/15] drm: rcar-du: Add support for external pixel clock
Message-Id: <1418254935-13536-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DU uses the module functional clock as the default pixel clock, but
supports using an externally supplied pixel clock instead. Support this
by adding the external pixel clock to the DT bindings, and selecting the
clock automatically at runtime based on the requested mode pixel
frequency.

The input clock pins to DU channels routing is configurable, but
currently hardcoded to connect input clock i to channel i.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/renesas,du.txt       |  4 ++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             | 60 +++++++++++++++++++---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c            | 14 ++++-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |  4 +-
 5 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt b/Documentation/devicetree/bindings/video/renesas,du.txt
index 5102830f2760..c902323928f7 100644
--- a/Documentation/devicetree/bindings/video/renesas,du.txt
+++ b/Documentation/devicetree/bindings/video/renesas,du.txt
@@ -26,6 +26,10 @@ Required Properties:
       per LVDS encoder. The functional clocks must be named "du.x" with "x"
       being the channel numerical index. The LVDS clocks must be named
       "lvds.x" with "x" being the LVDS encoder numerical index.
+    - In addition to the functional and encoder clocks, all DU versions also
+      support externally supplied pixel clocks. Those clocks are optional.
+      When supplied they must be named "dclkin.x" with "x" being the input
+      clock numerical index.
 
 Required nodes:
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index cf0dca13264f..ce280bd390a9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -74,33 +74,71 @@ static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(rcrtc->extclock);
+	if (ret < 0)
+		goto error_clock;
+
 	ret = rcar_du_group_get(rcrtc->group);
 	if (ret < 0)
-		clk_disable_unprepare(rcrtc->clock);
+		goto error_group;
+
+	return 0;
 
+error_group:
+	clk_disable_unprepare(rcrtc->extclock);
+error_clock:
+	clk_disable_unprepare(rcrtc->clock);
 	return ret;
 }
 
 static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
 {
 	rcar_du_group_put(rcrtc->group);
+
+	clk_disable_unprepare(rcrtc->extclock);
 	clk_disable_unprepare(rcrtc->clock);
 }
 
 static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 {
 	const struct drm_display_mode *mode = &rcrtc->crtc.mode;
+	unsigned long mode_clock = mode->clock * 1000;
 	unsigned long clk;
 	u32 value;
+	u32 escr;
 	u32 div;
 
-	/* Dot clock */
+	/* Compute the clock divisor and select the internal or external dot
+	 * clock based on the requested frequency.
+	 */
 	clk = clk_get_rate(rcrtc->clock);
-	div = DIV_ROUND_CLOSEST(clk, mode->clock * 1000);
+	div = DIV_ROUND_CLOSEST(clk, mode_clock);
 	div = clamp(div, 1U, 64U) - 1;
+	escr = div | ESCR_DCLKSEL_CLKS;
+
+	if (rcrtc->extclock) {
+		unsigned long extclk;
+		unsigned long extrate;
+		unsigned long rate;
+		u32 extdiv;
+
+		extclk = clk_get_rate(rcrtc->extclock);
+		extdiv = DIV_ROUND_CLOSEST(extclk, mode_clock);
+		extdiv = clamp(extdiv, 1U, 64U) - 1;
+
+		rate = clk / (div + 1);
+		extrate = extclk / (extdiv + 1);
+
+		if (abs((long)extrate - (long)mode_clock) <
+		    abs((long)rate - (long)mode_clock)) {
+			dev_dbg(rcrtc->group->dev->dev,
+				"crtc%u: using external clock\n", rcrtc->index);
+			escr = extdiv | ESCR_DCLKSEL_DCLKIN;
+		}
+	}
 
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? ESCR2 : ESCR,
-			    ESCR_DCLKSEL_CLKS | div);
+			    escr);
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? OTAR2 : OTAR, 0);
 
 	/* Signal polarities */
@@ -543,12 +581,13 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 	struct rcar_du_crtc *rcrtc = &rcdu->crtcs[index];
 	struct drm_crtc *crtc = &rcrtc->crtc;
 	unsigned int irqflags;
-	char clk_name[5];
+	struct clk *clk;
+	char clk_name[9];
 	char *name;
 	int irq;
 	int ret;
 
-	/* Get the CRTC clock. */
+	/* Get the CRTC clock and the optional external clock. */
 	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CRTC_IRQ_CLOCK)) {
 		sprintf(clk_name, "du.%u", index);
 		name = clk_name;
@@ -562,6 +601,15 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 		return PTR_ERR(rcrtc->clock);
 	}
 
+	sprintf(clk_name, "dclkin.%u", index);
+	clk = devm_clk_get(rcdu->dev, clk_name);
+	if (!IS_ERR(clk)) {
+		rcrtc->extclock = clk;
+	} else if (PTR_ERR(rcrtc->clock) = -EPROBE_DEFER) {
+		dev_info(rcdu->dev, "can't get external clock %u\n", index);
+		return -EPROBE_DEFER;
+	}
+
 	rcrtc->group = rgrp;
 	rcrtc->mmio_offset = mmio_offsets[index];
 	rcrtc->index = index;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 984e6083699f..d2f89f7d2e5e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -26,6 +26,7 @@ struct rcar_du_crtc {
 	struct drm_crtc crtc;
 
 	struct clk *clock;
+	struct clk *extclock;
 	unsigned int mmio_offset;
 	unsigned int index;
 	bool started;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 7b6428234252..1bdc0ee0c248 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -66,9 +66,21 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	rcar_du_group_write(rgrp, DEFR4, DEFR4_CODE);
 	rcar_du_group_write(rgrp, DEFR5, DEFR5_CODE | DEFR5_DEFE5);
 
-	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS))
+	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS)) {
 		rcar_du_group_setup_defr8(rgrp);
 
+		/* Configure input dot clock routing. We currently hardcode the
+		 * configuration to routing DOTCLKINn to DUn.
+		 */
+		rcar_du_group_write(rgrp, DIDSR, DIDSR_CODE |
+				    DIDSR_LCDS_DCLKIN(2) |
+				    DIDSR_LCDS_DCLKIN(1) |
+				    DIDSR_LCDS_DCLKIN(0) |
+				    DIDSR_PDCS_CLK(2, 0) |
+				    DIDSR_PDCS_CLK(1, 0) |
+				    DIDSR_PDCS_CLK(0, 0));
+	}
+
 	/* Use DS1PR and DS2PR to configure planes priorities and connects the
 	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
 	 */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index 73f7347f740b..c3639d1db28b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -256,8 +256,8 @@
 #define DIDSR_LCDS_LVDS0(n)	(2 << (8 + (n) * 2))
 #define DIDSR_LCDS_LVDS1(n)	(3 << (8 + (n) * 2))
 #define DIDSR_LCDS_MASK(n)	(3 << (8 + (n) * 2))
-#define DIDSR_PCDS_CLK(n, clk)	(clk << ((n) * 2))
-#define DIDSR_PCDS_MASK(n)	(3 << ((n) * 2))
+#define DIDSR_PDCS_CLK(n, clk)	(clk << ((n) * 2))
+#define DIDSR_PDCS_MASK(n)	(3 << ((n) * 2))
 
 /* -----------------------------------------------------------------------------
  * Display Timing Generation Registers
-- 
2.0.4

