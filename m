From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:57 +0000
Subject: [PATCH v2 27/40] clocksource: sh_tmu: Add memory base to sh_tmu_channel structure
Message-Id: <1393603090-23144-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The channel memory base is channel-specific, add it to the channel
structure in preparation for support of multiple channels per device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 2c64e3f..5095256 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -40,6 +40,7 @@ struct sh_tmu_device;
 struct sh_tmu_channel {
 	struct sh_tmu_device *tmu;
 
+	void __iomem *base;
 	int irq;
 
 	unsigned long rate;
@@ -68,39 +69,35 @@ static DEFINE_RAW_SPINLOCK(sh_tmu_lock);
 
 static inline unsigned long sh_tmu_read(struct sh_tmu_channel *ch, int reg_nr)
 {
-	struct sh_timer_config *cfg = ch->tmu->pdev->dev.platform_data;
-	void __iomem *base = ch->tmu->mapbase;
 	unsigned long offs;
 
 	if (reg_nr = TSTR)
-		return ioread8(base - cfg->channel_offset);
+		return ioread8(ch->tmu->mapbase);
 
 	offs = reg_nr << 2;
 
 	if (reg_nr = TCR)
-		return ioread16(base + offs);
+		return ioread16(ch->base + offs);
 	else
-		return ioread32(base + offs);
+		return ioread32(ch->base + offs);
 }
 
 static inline void sh_tmu_write(struct sh_tmu_channel *ch, int reg_nr,
 				unsigned long value)
 {
-	struct sh_timer_config *cfg = ch->tmu->pdev->dev.platform_data;
-	void __iomem *base = ch->tmu->mapbase;
 	unsigned long offs;
 
 	if (reg_nr = TSTR) {
-		iowrite8(value, base - cfg->channel_offset);
+		iowrite8(value, ch->tmu->mapbase);
 		return;
 	}
 
 	offs = reg_nr << 2;
 
 	if (reg_nr = TCR)
-		iowrite16(value, base + offs);
+		iowrite16(value, ch->base + offs);
 	else
-		iowrite32(value, base + offs);
+		iowrite32(value, ch->base + offs);
 }
 
 static void sh_tmu_start_stop_ch(struct sh_tmu_channel *ch, int start)
@@ -481,13 +478,18 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* map memory, let mapbase point to our channel */
-	tmu->mapbase = ioremap_nocache(res->start, resource_size(res));
-	if (tmu->mapbase = NULL) {
+	/*
+	 * Map memory, let channel.base point to our channel and mapbase to the
+	 * start/stop shared register.
+	 */
+	tmu->channel.base = ioremap_nocache(res->start, resource_size(res));
+	if (tmu->channel.base = NULL) {
 		dev_err(&tmu->pdev->dev, "failed to remap I/O memory\n");
 		goto err0;
 	}
 
+	tmu->mapbase = tmu->channel.base - cfg->channel_offset;
+
 	/* get hold of clock */
 	tmu->clk = clk_get(&tmu->pdev->dev, "tmu_fck");
 	if (IS_ERR(tmu->clk)) {
-- 
1.8.3.2

