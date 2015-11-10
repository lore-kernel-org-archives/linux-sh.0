From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 10 Nov 2015 13:39:00 +0000
Subject: [PATCH] media: adv7180: increase delay after reset to 5ms
Message-Id: <1447162740-28096-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Initialization of the ADV7180 chip fails on the Renesas R8A7790-based
Lager board about 50% of the time.  This patch resolves the issue by
increasing the minimum delay after reset from 2 ms to 5 ms, following the
recommendation in the ADV7180 datasheet:

"Executing a software reset takes approximately 2 ms. However, it is
recommended to wait 5 ms before any further I2C writes are performed."

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/media/i2c/adv7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index f82c8aa..3c3c4bf 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -1112,7 +1112,7 @@ static int init_device(struct adv7180_state *state)
 	mutex_lock(&state->mutex);
 
 	adv7180_write(state, ADV7180_REG_PWR_MAN, ADV7180_PWR_MAN_RES);
-	usleep_range(2000, 10000);
+	usleep_range(5000, 10000);
 
 	ret = state->chip_info->init(state);
 	if (ret)
-- 
2.6.1

