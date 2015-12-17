From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:39:48 +0000
Subject: [PATCH/RFC 10/48] v4l: vsp1: Enable display list support for the HS[IT], LUT, SRU and UDS
Message-Id: <1450341626-6695-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Those modules were left out of display list integration as they're not
used by the DRM pipeline. To prepare for display list support in non-DRM
pipelines use the module write API to set registers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_hsit.c | 2 +-
 drivers/media/platform/vsp1/vsp1_lut.c  | 2 +-
 drivers/media/platform/vsp1/vsp1_sru.c  | 2 +-
 drivers/media/platform/vsp1/vsp1_uds.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_hsit.c b/drivers/media/platform/vsp1/vsp1_hsit.c
index c1087cff31a0..e820fe0b4f00 100644
--- a/drivers/media/platform/vsp1/vsp1_hsit.c
+++ b/drivers/media/platform/vsp1/vsp1_hsit.c
@@ -28,7 +28,7 @@
 
 static inline void vsp1_hsit_write(struct vsp1_hsit *hsit, u32 reg, u32 data)
 {
-	vsp1_write(hsit->entity.vsp1, reg, data);
+	vsp1_mod_write(&hsit->entity, reg, data);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/media/platform/vsp1/vsp1_lut.c b/drivers/media/platform/vsp1/vsp1_lut.c
index 4b89095e7b5f..fc9011b12993 100644
--- a/drivers/media/platform/vsp1/vsp1_lut.c
+++ b/drivers/media/platform/vsp1/vsp1_lut.c
@@ -29,7 +29,7 @@
 
 static inline void vsp1_lut_write(struct vsp1_lut *lut, u32 reg, u32 data)
 {
-	vsp1_write(lut->entity.vsp1, reg, data);
+	vsp1_mod_write(&lut->entity, reg, data);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index 15fc562a52da..810c6b376e14 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -28,7 +28,7 @@
 
 static inline void vsp1_sru_write(struct vsp1_sru *sru, u32 reg, u32 data)
 {
-	vsp1_write(sru->entity.vsp1, reg, data);
+	vsp1_mod_write(&sru->entity, reg, data);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index bba67770cf95..c608b06ed677 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -31,8 +31,8 @@
 
 static inline void vsp1_uds_write(struct vsp1_uds *uds, u32 reg, u32 data)
 {
-	vsp1_write(uds->entity.vsp1,
-		   reg + uds->entity.index * VI6_UDS_OFFSET, data);
+	vsp1_mod_write(&uds->entity, reg + uds->entity.index * VI6_UDS_OFFSET,
+		       data);
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.4.10

