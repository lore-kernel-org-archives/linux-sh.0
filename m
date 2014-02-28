From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:40 +0000
Subject: [PATCH v2 10/40] clocksource: sh_cmt: Replace kmalloc + memset with kzalloc
Message-Id: <1393603090-23144-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

One kzalloc a day keeps the bugs away.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 6b65621..0779bf1 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -672,8 +672,6 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 {
 	struct clock_event_device *ced = &ch->ced;
 
-	memset(ced, 0, sizeof(*ced));
-
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
@@ -709,7 +707,6 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 	int irq;
 	int ret;
 
-	memset(ch, 0, sizeof(*ch));
 	ch->cmt = cmt;
 	ch->base = cmt->mapbase_ch;
 	ch->index = index;
@@ -758,7 +755,6 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	int ret;
 	ret = -ENXIO;
 
-	memset(cmt, 0, sizeof(*cmt));
 	cmt->pdev = pdev;
 
 	if (!cfg) {
@@ -861,7 +857,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	cmt = kmalloc(sizeof(*cmt), GFP_KERNEL);
+	cmt = kzalloc(sizeof(*cmt), GFP_KERNEL);
 	if (cmt = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
-- 
1.8.3.2

