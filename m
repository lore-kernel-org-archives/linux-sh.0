From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 Jan 2016 21:56:49 +0000
Subject: [PATCH v2 2/3] drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
Message-Id: <1452290210-20629-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This register includes a counter which is decremented by the chip on I2C
failures. Also, it is reset when powering down.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/gpu/drm/i2c/adv7511.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index db7435a4517fb4..e1756a452d6980 100644
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

