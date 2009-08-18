From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 18 Aug 2009 07:00:20 +0000
Subject: [PATCH] heartbeat: add bit mask operation on heartbeat_toggle_bit
Message-Id: <uab1xy5bv.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Current heartbeat driver has the possibility
to change area that is not LED.
This patch add bit mask operation to not change it.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/drivers/heartbeat.c     |   10 ++++++++++
 arch/sh/include/asm/heartbeat.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index 938817e..a9339a6 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -40,14 +40,19 @@ static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
 	if (inverted)
 		new = ~new;
 
+	new &= hd->mask;
+
 	switch (hd->regsize) {
 	case 32:
+		new |= ioread32(hd->base) & ~hd->mask;
 		iowrite32(new, hd->base);
 		break;
 	case 16:
+		new |= ioread16(hd->base) & ~hd->mask;
 		iowrite16(new, hd->base);
 		break;
 	default:
+		new |= ioread8(hd->base) & ~hd->mask;
 		iowrite8(new, hd->base);
 		break;
 	}
@@ -72,6 +77,7 @@ static int heartbeat_drv_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct heartbeat_data *hd;
+	int i;
 
 	if (unlikely(pdev->num_resources != 1)) {
 		dev_err(&pdev->dev, "invalid number of resources\n");
@@ -107,6 +113,10 @@ static int heartbeat_drv_probe(struct platform_device *pdev)
 		hd->nr_bits = ARRAY_SIZE(default_bit_pos);
 	}
 
+	hd->mask = 0;
+	for (i = 0; i < hd->nr_bits; i++)
+		hd->mask |= (1 << hd->bit_pos[i]);
+
 	if (!hd->regsize)
 		hd->regsize = 8;	/* default access size */
 
diff --git a/arch/sh/include/asm/heartbeat.h b/arch/sh/include/asm/heartbeat.h
index 724a43e..caaafe5 100644
--- a/arch/sh/include/asm/heartbeat.h
+++ b/arch/sh/include/asm/heartbeat.h
@@ -11,6 +11,7 @@ struct heartbeat_data {
 	unsigned int nr_bits;
 	struct timer_list timer;
 	unsigned int regsize;
+	unsigned int mask;
 	unsigned long flags;
 };
 
-- 
1.6.0.4

