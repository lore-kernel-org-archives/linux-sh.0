From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:07 +0000
Subject: [PATCH 20/22] drm: rcar-du: lvds: Fix PLL frequency-related configuration
Message-Id: <1442184669-30990-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The frequency checks don't match the datasheet, fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
index 937b2da98814..e044a17a2a2f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -56,11 +56,11 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 		return ret;
 
 	/* PLL clock configuration */
-	if (freq <= 38000)
+	if (freq < 39000)
 		pllcr = LVDPLLCR_CEEN | LVDPLLCR_COSEL | LVDPLLCR_PLLDLYCNT_38M;
-	else if (freq <= 60000)
+	else if (freq < 61000)
 		pllcr = LVDPLLCR_CEEN | LVDPLLCR_COSEL | LVDPLLCR_PLLDLYCNT_60M;
-	else if (freq <= 121000)
+	else if (freq < 121000)
 		pllcr = LVDPLLCR_CEEN | LVDPLLCR_COSEL | LVDPLLCR_PLLDLYCNT_121M;
 	else
 		pllcr = LVDPLLCR_PLLDLYCNT_150M;
-- 
2.4.6

