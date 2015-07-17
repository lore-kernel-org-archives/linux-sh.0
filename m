From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:03 +0000
Subject: [PATCH 1/5] drm: rcar-du: Add support for the R8A7793 DU
Message-Id: <1437121567-18467-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

The R8A7793 DU is identical to the R8A7791 and thus only requires a new
DT compatible string.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/video/renesas,du.txt | 12 +++++++-----
 drivers/gpu/drm/rcar-du/rcar_du_drv.c                  |  4 +++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt b/Documentation/devicetree/bindings/video/renesas,du.txt
index c902323928f7..d05be121486f 100644
--- a/Documentation/devicetree/bindings/video/renesas,du.txt
+++ b/Documentation/devicetree/bindings/video/renesas,du.txt
@@ -5,7 +5,8 @@ Required Properties:
   - compatible: must be one of the following.
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
-    - "renesas,du-r8a7791" for R8A7791 (R-Car M2) compatible DU
+    - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
+    - "renesas,du-r8a7793" for R8A7793 (R-Car M2-N) compatible DU
 
   - reg: A list of base address and length of each memory resource, one for
     each entry in the reg-names property.
@@ -22,9 +23,9 @@ Required Properties:
   - clock-names: Name of the clocks. This property is model-dependent.
     - R8A7779 uses a single functional clock. The clock doesn't need to be
       named.
-    - R8A7790 and R8A7791 use one functional clock per channel and one clock
-      per LVDS encoder. The functional clocks must be named "du.x" with "x"
-      being the channel numerical index. The LVDS clocks must be named
+    - R8A779[013] use one functional clock per channel and one clock per LVDS
+      encoder (if available). The functional clocks must be named "du.x" with
+      "x" being the channel numerical index. The LVDS clocks must be named
       "lvds.x" with "x" being the LVDS encoder numerical index.
     - In addition to the functional and encoder clocks, all DU versions also
       support externally supplied pixel clocks. Those clocks are optional.
@@ -43,7 +44,8 @@ corresponding to each DU output.
 -----------------------------------------------------------------------------
  R8A7779 (H1)	DPAD 0		DPAD 1		-
  R8A7790 (H2)	DPAD		LVDS 0		LVDS 1
- R8A7791 (M2)	DPAD		LVDS 0		-
+ R8A7791 (M2-W)	DPAD		LVDS 0		-
+ R8A7793 (M2-N)	DPAD		LVDS 0		-
 
 
 Example: R8A7790 (R-Car H2) DU
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index cbb7d8530d79..5a7e6dfa5df2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -84,12 +84,13 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.num_lvds = 2,
 };
 
+/* M2-W (r8a7791) and M2-N (r8a7793) are identical */
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
 	.num_crtcs = 2,
 	.routes = {
-		/* R8A7791 has one RGB output, one LVDS output and one
+		/* R8A779[13] has one RGB output, one LVDS output and one
 		 * (currently unsupported) TCON output.
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
@@ -110,6 +111,7 @@ static const struct platform_device_id rcar_du_id_table[] = {
 	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
 	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
 	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
+	{ "rcar-du-r8a7793", (kernel_ulong_t)&rcar_du_r8a7791_info },
 	{ }
 };
 
-- 
2.3.6

