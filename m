From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Jun 2015 07:14:39 +0000
Subject: [PATCH 1/2] i2c: sh_mobile: add errata workaround
Message-Id: <1433834080-5630-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This used to be in platform init code. We want it to do in the driver
now. This is basically a code move and a new compatible added.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 007818b3e1745b..7193bcfdd94013 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -150,6 +150,7 @@ struct sh_mobile_i2c_data {
 
 struct sh_mobile_dt_config {
 	int clks_per_count;
+	void (*setup)(struct sh_mobile_i2c_data *pd);
 };
 
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
@@ -164,6 +165,7 @@ struct sh_mobile_dt_config {
 #define ICIC			0x0c
 #define ICCL			0x10
 #define ICCH			0x14
+#define ICSTART			0x70
 
 /* Register bits */
 #define ICCR_ICE		0x80
@@ -190,6 +192,8 @@ struct sh_mobile_dt_config {
 #define ICIC_WAITE		0x02
 #define ICIC_DTEE		0x01
 
+#define ICSTART_ICSTART		0x10
+
 static void iic_wr(struct sh_mobile_i2c_data *pd, int offs, unsigned char data)
 {
 	if (offs = ICIC)
@@ -782,6 +786,33 @@ static struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
+/*
+ * r8a7740 chip has lasting errata on I2C I/O pad reset.
+ * this is work-around for it.
+ */
+static void sh_mobile_i2c_r8a7740_workaround(struct sh_mobile_i2c_data *pd)
+{
+	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
+	iic_rd(pd, ICCR); /* dummy read */
+
+	iic_set_clr(pd, ICSTART, ICSTART_ICSTART, 0);
+	iic_rd(pd, ICSTART); /* dummy read */
+
+	udelay(10);
+
+	iic_wr(pd, ICCR, ICCR_SCP);
+	iic_wr(pd, ICSTART, 0);
+
+	udelay(10);
+
+	iic_wr(pd, ICCR, ICCR_TRS);
+	udelay(10);
+	iic_wr(pd, ICCR, 0);
+	udelay(10);
+	iic_wr(pd, ICCR, ICCR_TRS);
+	udelay(10);
+}
+
 static const struct sh_mobile_dt_config default_dt_config = {
 	.clks_per_count = 1,
 };
@@ -790,9 +821,15 @@ static const struct sh_mobile_dt_config fast_clock_dt_config = {
 	.clks_per_count = 2,
 };
 
+static const struct sh_mobile_dt_config r8a7740_dt_config = {
+	.clks_per_count = 1,
+	.setup = sh_mobile_i2c_r8a7740_workaround,
+};
+
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
@@ -885,6 +922,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 			config = match->data;
 			pd->clks_per_count = config->clks_per_count;
+
+			if (config->setup)
+				config->setup(pd);
 		}
 	} else {
 		if (pdata && pdata->bus_speed)
-- 
2.1.4

