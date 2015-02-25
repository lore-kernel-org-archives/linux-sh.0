From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:26 +0000
Subject: [PATCH 06/38] drm: adv7511: Fix nested sleep when reading EDID
Message-Id: <1424901298-6829-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The EDID read code waits for the read completion interrupt to occur
using wait_event_interruptible(). The condition passed to the macro
reads I2C registers. This results in sleeping with the task state set
to TASK_INTERRUPTIBLE, triggering a WARN_ON() introduced in commit
8eb23b9f35aae ("sched: Debug nested sleeps").

Fix this by reworking the EDID read code. Instead of checking whether
the read is complete through I2C reads, handle the interrupt registers
in the interrupt handler and update a new edid_read flag accordingly. As
a side effect both the IRQ and polling code paths now process the
interrupt sources through the same code path, simplifying the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/i2c/adv7511.c | 96 +++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index 5109c215018e..60ab1f75d58e 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -33,6 +33,7 @@ struct adv7511 {
 
 	unsigned int current_edid_segment;
 	uint8_t edid_buf[256];
+	bool edid_read;
 
 	wait_queue_head_t wq;
 	struct drm_encoder *encoder;
@@ -379,69 +380,71 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
 	return false;
 }
 
-static irqreturn_t adv7511_irq_handler(int irq, void *devid)
-{
-	struct adv7511 *adv7511 = devid;
-
-	if (adv7511_hpd(adv7511))
-		drm_helper_hpd_irq_event(adv7511->encoder->dev);
-
-	wake_up_all(&adv7511->wq);
-
-	return IRQ_HANDLED;
-}
-
-static unsigned int adv7511_is_interrupt_pending(struct adv7511 *adv7511,
-						 unsigned int irq)
+static int adv7511_irq_process(struct adv7511 *adv7511)
 {
 	unsigned int irq0, irq1;
-	unsigned int pending;
 	int ret;
 
 	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
 	if (ret < 0)
-		return 0;
+		return ret;
+
 	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
 	if (ret < 0)
-		return 0;
+		return ret;
+
+	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
+	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
+
+	if (irq0 & ADV7511_INT0_HDP)
+		drm_helper_hpd_irq_event(adv7511->encoder->dev);
+
+	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
+		adv7511->edid_read = true;
 
-	pending = (irq1 << 8) | irq0;
+		if (adv7511->i2c_main->irq)
+			wake_up_all(&adv7511->wq);
+	}
 
-	return pending & irq;
+	return 0;
 }
 
-static int adv7511_wait_for_interrupt(struct adv7511 *adv7511, int irq,
-				      int timeout)
+static irqreturn_t adv7511_irq_handler(int irq, void *devid)
+{
+	struct adv7511 *adv7511 = devid;
+	int ret;
+
+	ret = adv7511_irq_process(adv7511);
+	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------------
+ * EDID retrieval
+ */
+
+static int adv7511_wait_for_edid(struct adv7511 *adv7511, int timeout)
 {
-	unsigned int pending;
 	int ret;
 
 	if (adv7511->i2c_main->irq) {
 		ret = wait_event_interruptible_timeout(adv7511->wq,
-				adv7511_is_interrupt_pending(adv7511, irq),
-				msecs_to_jiffies(timeout));
-		if (ret <= 0)
-			return 0;
-		pending = adv7511_is_interrupt_pending(adv7511, irq);
+				adv7511->edid_read, msecs_to_jiffies(timeout));
 	} else {
-		if (timeout < 25)
-			timeout = 25;
-		do {
-			pending = adv7511_is_interrupt_pending(adv7511, irq);
-			if (pending)
+		for (; timeout > 0; timeout -= 25) {
+			ret = adv7511_irq_process(adv7511);
+			if (ret < 0)
+				break;
+
+			if (adv7511->edid_read)
 				break;
+
 			msleep(25);
-			timeout -= 25;
-		} while (timeout >= 25);
+		}
 	}
 
-	return pending;
+	return adv7511->edid_read ? 0 : -EIO;
 }
 
-/* -----------------------------------------------------------------------------
- * EDID retrieval
- */
-
 static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
 				  size_t len)
 {
@@ -463,21 +466,14 @@ static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
 			return ret;
 
 		if (status != 2) {
+			adv7511->edid_read = false;
 			regmap_write(adv7511->regmap, ADV7511_REG_EDID_SEGMENT,
 				     block);
-			ret = adv7511_wait_for_interrupt(adv7511,
-					ADV7511_INT0_EDID_READY |
-					(ADV7511_INT1_DDC_ERROR << 8), 200);
-
-			if (!(ret & ADV7511_INT0_EDID_READY))
-				return -EIO;
+			ret = adv7511_wait_for_edid(adv7511, 200);
+			if (ret < 0)
+				return ret;
 		}
 
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_EDID_READY);
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
-			     ADV7511_INT1_DDC_ERROR);
-
 		/* Break this apart, hopefully more I2C controllers will
 		 * support 64 byte transfers than 256 byte transfers
 		 */
-- 
2.0.5

