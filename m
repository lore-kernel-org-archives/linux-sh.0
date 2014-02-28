From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:38 +0000
Subject: [PATCH v2 08/40] clocksource: sh_cmt: Add memory base to sh_cmt_channel structure
Message-Id: <1393603090-23144-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The channel memory base is channel-specific, add it to the channel
structure in preparation for support of multiple channels per device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index eb93b88..4fcb05d 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -40,6 +40,8 @@ struct sh_cmt_device;
 struct sh_cmt_channel {
 	struct sh_cmt_device *cmt;
 
+	void __iomem *base;
+
 	unsigned long flags;
 	unsigned long match_value;
 	unsigned long next_match_value;
@@ -130,12 +132,12 @@ static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 {
-	return ch->cmt->read_control(ch->cmt->mapbase_ch, CMCSR);
+	return ch->cmt->read_control(ch->base, CMCSR);
 }
 
 static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 {
-	return ch->cmt->read_count(ch->cmt->mapbase_ch, CMCNT);
+	return ch->cmt->read_count(ch->base, CMCNT);
 }
 
 static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
@@ -147,19 +149,19 @@ static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_control(ch->cmt->mapbase_ch, CMCSR, value);
+	ch->cmt->write_control(ch->base, CMCSR, value);
 }
 
 static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_count(ch->cmt->mapbase_ch, CMCNT, value);
+	ch->cmt->write_count(ch->base, CMCNT, value);
 }
 
 static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_count(ch->cmt->mapbase_ch, CMCOR, value);
+	ch->cmt->write_count(ch->base, CMCOR, value);
 }
 
 static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
@@ -702,6 +704,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch,
 
 	memset(ch, 0, sizeof(*ch));
 	ch->cmt = cmt;
+	ch->base = cmt->mapbase_ch;
 
 	irq = platform_get_irq(cmt->pdev, 0);
 	if (irq < 0) {
-- 
1.8.3.2

