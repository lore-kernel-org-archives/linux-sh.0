From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:15 +0000
Subject: [PATCH 08/22] clocksource: sh_mtu2: Add index to struct sh_mtu2_channel
Message-Id: <1393955249-18736-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the index as the timer start/stop bit and when printing messages to
identify the channel.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 97714ce..61827c6 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -38,6 +38,7 @@ struct sh_mtu2_device;
 
 struct sh_mtu2_channel {
 	struct sh_mtu2_device *mtu;
+	unsigned int index;
 
 	void __iomem *base;
 	int irq;
@@ -110,7 +111,6 @@ static inline void sh_mtu2_write(struct sh_mtu2_channel *ch, int reg_nr,
 
 static void sh_mtu2_start_stop_ch(struct sh_mtu2_channel *ch, int start)
 {
-	struct sh_timer_config *cfg = ch->mtu->pdev->dev.platform_data;
 	unsigned long flags, value;
 
 	/* start stop register shared by multiple timer channels */
@@ -118,9 +118,9 @@ static void sh_mtu2_start_stop_ch(struct sh_mtu2_channel *ch, int start)
 	value = sh_mtu2_read(ch, TSTR);
 
 	if (start)
-		value |= 1 << cfg->timer_bit;
+		value |= 1 << ch->index;
 	else
-		value &= ~(1 << cfg->timer_bit);
+		value &= ~(1 << ch->index);
 
 	sh_mtu2_write(ch, TSTR, value);
 	raw_spin_unlock_irqrestore(&sh_mtu2_lock, flags);
@@ -138,7 +138,8 @@ static int sh_mtu2_enable(struct sh_mtu2_channel *ch)
 	/* enable clock */
 	ret = clk_enable(ch->mtu->clk);
 	if (ret) {
-		dev_err(&ch->mtu->pdev->dev, "cannot enable clock\n");
+		dev_err(&ch->mtu->pdev->dev, "ch%u: cannot enable clock\n",
+			ch->index);
 		return ret;
 	}
 
@@ -211,7 +212,7 @@ static void sh_mtu2_clock_event_mode(enum clock_event_mode mode,
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		dev_info(&ch->mtu->pdev->dev,
-			 "used for periodic clock events\n");
+			 "ch%u: used for periodic clock events\n", ch->index);
 		sh_mtu2_enable(ch);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
@@ -250,15 +251,16 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 	ced->suspend = sh_mtu2_clock_event_suspend;
 	ced->resume = sh_mtu2_clock_event_resume;
 
-	dev_info(&ch->mtu->pdev->dev, "used for clock events\n");
+	dev_info(&ch->mtu->pdev->dev, "ch%u: used for clock events\n",
+		 ch->index);
 	clockevents_register_device(ced);
 
 	ret = request_irq(ch->irq, sh_mtu2_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
 			  dev_name(&ch->mtu->pdev->dev), ch);
 	if (ret) {
-		dev_err(&ch->mtu->pdev->dev, "failed to request irq %d\n",
-			ch->irq);
+		dev_err(&ch->mtu->pdev->dev, "ch%u: failed to request irq %d\n",
+			ch->index, ch->irq);
 		return;
 	}
 }
@@ -279,10 +281,12 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
 
 	memset(ch, 0, sizeof(*ch));
 	ch->mtu = mtu;
+	ch->index = cfg->timer_bit;
 
 	ch->irq = platform_get_irq(mtu->pdev, 0);
 	if (ch->irq < 0) {
-		dev_err(&mtu->pdev->dev, "failed to get irq\n");
+		dev_err(&mtu->pdev->dev, "ch%u: failed to get irq\n",
+			ch->index);
 		return ch->irq;
 	}
 
-- 
1.8.3.2

