From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:25 +0000
Subject: [PATCH 05/38] drm: adv7511: Fix DDC error interrupt handling
Message-Id: <1424901298-6829-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DDC error interrupt bit is located in REG_INT1, not REG_INT0. Update
both the interrupt wait code and the interrupt sources reset code
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/i2c/adv7511.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index fa140e04d5fa..5109c215018e 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -467,14 +467,16 @@ static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
 				     block);
 			ret = adv7511_wait_for_interrupt(adv7511,
 					ADV7511_INT0_EDID_READY |
-					ADV7511_INT1_DDC_ERROR, 200);
+					(ADV7511_INT1_DDC_ERROR << 8), 200);
 
 			if (!(ret & ADV7511_INT0_EDID_READY))
 				return -EIO;
 		}
 
 		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+			     ADV7511_INT0_EDID_READY);
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
+			     ADV7511_INT1_DDC_ERROR);
 
 		/* Break this apart, hopefully more I2C controllers will
 		 * support 64 byte transfers than 256 byte transfers
@@ -528,7 +530,9 @@ static int adv7511_get_modes(struct drm_encoder *encoder,
 	/* Reading the EDID only works if the device is powered */
 	if (adv7511->dpms_mode != DRM_MODE_DPMS_ON) {
 		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+			     ADV7511_INT0_EDID_READY);
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
+			     ADV7511_INT1_DDC_ERROR);
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
 				   ADV7511_POWER_POWER_DOWN, 0);
 		adv7511->current_edid_segment = -1;
@@ -563,7 +567,9 @@ static void adv7511_encoder_dpms(struct drm_encoder *encoder, int mode)
 		adv7511->current_edid_segment = -1;
 
 		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+			     ADV7511_INT0_EDID_READY);
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
+			     ADV7511_INT1_DDC_ERROR);
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
 				   ADV7511_POWER_POWER_DOWN, 0);
 		/*
-- 
2.0.5

