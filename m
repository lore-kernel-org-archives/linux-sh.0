From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 24 Nov 2015 15:00:44 +0000
Subject: [PATCH] drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
Message-Id: <1448377244-15888-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This register includes a counter which is decremented by the chip on I2C
failures. Also, it is reset when powering down.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/i2c/adv7511.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index 85e994796d96a4..50a861b12346c4 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -136,6 +136,7 @@ static bool adv7511_register_volatile(struct device *dev, unsigned int reg)
 	case ADV7511_REG_BKSV(3):
 	case ADV7511_REG_BKSV(4):
 	case ADV7511_REG_DDC_STATUS:
+	case ADV7511_REG_EDID_READ_CTRL:
 	case ADV7511_REG_BSTATUS(0):
 	case ADV7511_REG_BSTATUS(1):
 	case ADV7511_REG_CHIP_ID_HIGH:
-- 
2.1.4

