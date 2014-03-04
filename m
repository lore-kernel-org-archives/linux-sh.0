From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:14 +0000
Subject: [PATCH 07/22] clocksource: sh_mtu2: Add memory base to sh_mtu2_channel structure
Message-Id: <1393955249-18736-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The channel memory base is channel-specific, add it to the channel
structure in preparation for support of multiple channels per device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 2fe3ab4c..97714ce 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -38,7 +38,10 @@ struct sh_mtu2_device;
 
 struct sh_mtu2_channel {
 	struct sh_mtu2_device *mtu;
+
+	void __iomem *base;
 	int irq;
+
 	struct clock_event_device ced;
 };
 
@@ -74,39 +77,35 @@ static unsigned long mtu2_reg_offs[] = {
 
 static inline unsigned long sh_mtu2_read(struct sh_mtu2_channel *ch, int reg_nr)
 {
-	struct sh_timer_config *cfg = ch->mtu->pdev->dev.platform_data;
-	void __iomem *base = ch->mtu->mapbase;
 	unsigned long offs;
 
 	if (reg_nr = TSTR)
-		return ioread8(base + cfg->channel_offset);
+		return ioread8(ch->mtu->mapbase);
 
 	offs = mtu2_reg_offs[reg_nr];
 
 	if ((reg_nr = TCNT) || (reg_nr = TGR))
-		return ioread16(base + offs);
+		return ioread16(ch->base + offs);
 	else
-		return ioread8(base + offs);
+		return ioread8(ch->base + offs);
 }
 
 static inline void sh_mtu2_write(struct sh_mtu2_channel *ch, int reg_nr,
 				unsigned long value)
 {
-	struct sh_timer_config *cfg = ch->mtu->pdev->dev.platform_data;
-	void __iomem *base = ch->mtu->mapbase;
 	unsigned long offs;
 
 	if (reg_nr = TSTR) {
-		iowrite8(value, base + cfg->channel_offset);
+		iowrite8(value, ch->mtu->mapbase);
 		return;
 	}
 
 	offs = mtu2_reg_offs[reg_nr];
 
 	if ((reg_nr = TCNT) || (reg_nr = TGR))
-		iowrite16(value, base + offs);
+		iowrite16(value, ch->base + offs);
 	else
-		iowrite8(value, base + offs);
+		iowrite8(value, ch->base + offs);
 }
 
 static void sh_mtu2_start_stop_ch(struct sh_mtu2_channel *ch, int start)
@@ -315,13 +314,18 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 		goto err0;
 	}
 
-	/* map memory, let mapbase point to our channel */
-	mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
-	if (mtu->mapbase = NULL) {
+	/*
+	 * Map memory, let channel.base point to our channel and mapbase to the
+	 * start/stop shared register.
+	 */
+	mtu->channel.base = ioremap_nocache(res->start, resource_size(res));
+	if (mtu->channel.base = NULL) {
 		dev_err(&mtu->pdev->dev, "failed to remap I/O memory\n");
 		goto err0;
 	}
 
+	mtu->mapbase = mtu->channel.base + cfg->channel_offset;
+
 	/* get hold of clock */
 	mtu->clk = clk_get(&mtu->pdev->dev, "mtu2_fck");
 	if (IS_ERR(mtu->clk)) {
@@ -344,7 +348,7 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
  err2:
 	clk_put(mtu->clk);
  err1:
-	iounmap(mtu->mapbase);
+	iounmap(mtu->channel.base);
  err0:
 	return ret;
 }
-- 
1.8.3.2

