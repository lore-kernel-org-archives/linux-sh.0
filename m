From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:58:10 +0000
Subject: [PATCH v2 40/40] clocksource: sh_cmt: Replace global spinlock with a per-device spinlock
Message-Id: <1393603090-23144-41-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The global spinlock is used to protect the shared start/stop register.
Now that all CMT channels are handled by a single device instance, use a
per-device spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 2214c73..0672165 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -118,6 +118,8 @@ struct sh_cmt_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
+	raw_spinlock_t lock; /* Protect the shared start/stop register */
+
 	struct sh_cmt_channel *channels;
 	unsigned int num_channels;
 
@@ -299,14 +301,12 @@ static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
 	return v2;
 }
 
-static DEFINE_RAW_SPINLOCK(sh_cmt_lock);
-
 static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 {
 	unsigned long flags, value;
 
 	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&sh_cmt_lock, flags);
+	raw_spin_lock_irqsave(&ch->cmt->lock, flags);
 	value = sh_cmt_read_cmstr(ch);
 
 	if (start)
@@ -315,7 +315,7 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 		value &= ~(1 << ch->timer_bit);
 
 	sh_cmt_write_cmstr(ch, value);
-	raw_spin_unlock_irqrestore(&sh_cmt_lock, flags);
+	raw_spin_unlock_irqrestore(&ch->cmt->lock, flags);
 }
 
 static int sh_cmt_enable(struct sh_cmt_channel *ch, unsigned long *rate)
@@ -926,6 +926,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 
 	memset(cmt, 0, sizeof(*cmt));
 	cmt->pdev = pdev;
+	raw_spin_lock_init(&cmt->lock);
 
 	if (!cfg) {
 		dev_err(&cmt->pdev->dev, "missing platform data\n");
-- 
1.8.3.2

