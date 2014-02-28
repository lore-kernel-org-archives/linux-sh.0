From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:51 +0000
Subject: [PATCH v2 21/40] clocksource: sh_cmt: Request IRQ for clock event device only
Message-Id: <1393603090-23144-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Clock sources don't need an IRQ, request the IRQ only for channels used
as clock event devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 9f215e7..d1b1948 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -789,6 +789,8 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 				       const char *name)
 {
 	struct clock_event_device *ced = &ch->ced;
+	int irq;
+	int ret;
 
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
@@ -803,6 +805,20 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used for clock events\n",
 		 ch->index);
 	clockevents_register_device(ced);
+
+	irq = platform_get_irq(ch->cmt->pdev, ch->cmt->legacy ? 0 : ch->index);
+	if (irq < 0) {
+		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
+			ch->index);
+		return;
+	}
+
+	ret = request_irq(irq, sh_cmt_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
+			  dev_name(&ch->cmt->pdev->dev), ch);
+	if (ret)
+		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to request irq %d\n",
+			ch->index, irq);
 }
 
 static int sh_cmt_register(struct sh_cmt_channel *ch, const char *name,
@@ -825,7 +841,6 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 				unsigned int hwidx, bool clockevent,
 				bool clocksource, struct sh_cmt_device *cmt)
 {
-	int irq;
 	int ret;
 
 	/* Skip unused channels. */
@@ -869,17 +884,6 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 		}
 	}
 
-	if (cmt->legacy)
-		irq = platform_get_irq(cmt->pdev, 0);
-	else
-		irq = platform_get_irq(cmt->pdev, ch->index);
-
-	if (irq < 0) {
-		dev_err(&cmt->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
-		return irq;
-	}
-
 	if (cmt->info->width = (sizeof(ch->max_match_value) * 8))
 		ch->max_match_value = ~0;
 	else
@@ -904,15 +908,6 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 	}
 	ch->cs_enabled = false;
 
-	ret = request_irq(irq, sh_cmt_interrupt,
-			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
-			  dev_name(&cmt->pdev->dev), ch);
-	if (ret) {
-		dev_err(&cmt->pdev->dev, "ch%u: failed to request irq %d\n",
-			ch->index, irq);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
1.8.3.2

