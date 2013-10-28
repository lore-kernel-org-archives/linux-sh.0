From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 22:49:22 +0000
Subject: [PATCH 05/12] drm: shmob_drm: Convert to clk_prepare/unprepare
Message-Id: <1383000569-8916-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 54bad98..562f9a4 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -40,7 +40,7 @@
 static void shmob_drm_clk_on(struct shmob_drm_device *sdev)
 {
 	if (sdev->clock)
-		clk_enable(sdev->clock);
+		clk_prepare_enable(sdev->clock);
 #if 0
 	if (sdev->meram_dev && sdev->meram_dev->pdev)
 		pm_runtime_get_sync(&sdev->meram_dev->pdev->dev);
@@ -54,7 +54,7 @@ static void shmob_drm_clk_off(struct shmob_drm_device *sdev)
 		pm_runtime_put_sync(&sdev->meram_dev->pdev->dev);
 #endif
 	if (sdev->clock)
-		clk_disable(sdev->clock);
+		clk_disable_unprepare(sdev->clock);
 }
 
 /* -----------------------------------------------------------------------------
-- 
1.8.1.5

