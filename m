From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 24 Nov 2015 14:50:27 +0000
Subject: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The interrupts for EDID_READY or DDC_ERROR were never enabled in this
driver, so reading EDID always timed out when the chip was powered down
and interrupts were used. Fix this and remove clearing the interrupt flags,
since they are cleared in POWER_DOWN mode anyhow (according to docs and my
tests).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

With this patch, I can read EDID in power-down mode reliably with my Lager
board. Tried with and without interrupts with two different monitors. I think
this patch should go to stable.

Note that I could not yet read EDID with Magnus' Koelsch. However, the
registers show that the interrupt flag and interrupt enable flag are both
correctly set (they were not before this patch). I assume a pinmuxing problem
or similar.

 drivers/gpu/drm/i2c/adv7511.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index 00416f23b5cb5f..85e994796d96a4 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -362,12 +362,19 @@ static void adv7511_power_on(struct adv7511 *adv7511)
 {
 	adv7511->current_edid_segment = -1;
 
-	regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-		     ADV7511_INT0_EDID_READY);
-	regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
-		     ADV7511_INT1_DDC_ERROR);
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
 			   ADV7511_POWER_POWER_DOWN, 0);
+	if (adv7511->i2c_main->irq) {
+		/*
+		 * Documentation says the INT_ENABLE registers are reset in
+		 * POWER_DOWN mode. My tests with a 7511w show something else
+		 * but let's stick to the documentation.
+		 */
+		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
+			     ADV7511_INT0_EDID_READY);
+		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
+			     ADV7511_INT1_DDC_ERROR);
+	}
 
 	/*
 	 * Per spec it is allowed to pulse the HDP signal to indicate that the
@@ -567,12 +574,14 @@ static int adv7511_get_modes(struct drm_encoder *encoder,
 
 	/* Reading the EDID only works if the device is powered */
 	if (!adv7511->powered) {
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_EDID_READY);
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
-			     ADV7511_INT1_DDC_ERROR);
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
 				   ADV7511_POWER_POWER_DOWN, 0);
+		if (adv7511->i2c_main->irq) {
+			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
+				     ADV7511_INT0_EDID_READY);
+			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
+				     ADV7511_INT1_DDC_ERROR);
+		}
 		adv7511->current_edid_segment = -1;
 	}
 
-- 
2.1.4

