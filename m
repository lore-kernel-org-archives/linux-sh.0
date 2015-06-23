From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 23 Jun 2015 12:58:52 +0000
Subject: [PATCH] drm: rcar-du: Remove obsolete rcar-du-r8a779x platform_device_id entries
Message-Id: <1435064332-11503-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
board support"), R-Car Gen2 SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 780ca11512ba6cf1..fb6709160a591a4d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -108,8 +108,6 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 
 static const struct platform_device_id rcar_du_id_table[] = {
 	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
-	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
-	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
 	{ }
 };
 
-- 
1.9.1

