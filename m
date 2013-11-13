From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:52:15 +0000
Subject: [PATCH 5/5] drm/rcar-du: Add support for the r8a7791 DU
Message-Id: <1384350735-4419-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The r8a7791 DU is a stripped-down version of the r8a7790 DU with two
CRTCs and a single LVDS output.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 4eee02f..5536811 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -272,9 +272,29 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.num_lvds = 2,
 };
 
+static const struct rcar_du_device_info rcar_du_r8a7791_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.num_crtcs = 2,
+	.routes = {
+		/* R8A7791 has one RGB output, one LVDS output and one
+		 * (currently unsupported) TCON output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+		},
+	},
+	.num_lvds = 1,
+};
+
 static const struct platform_device_id rcar_du_id_table[] = {
 	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
 	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
+	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
 	{ }
 };
 
-- 
1.8.3.2

