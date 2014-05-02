From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:14 +0000
Subject: [PATCH v2 08/10] i2c: sh_mobile: bail out on errors when initializing
Message-Id: <1399058116-7721-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

sh_mobile_i2c_init() could detect wrong settings, but didn't bail out,
so it would continue unconfigured. Fix this.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9a5b693454e1..9f02013eaeeb 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -228,7 +228,7 @@ static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf)
 	return (((count_khz * (tHIGH + tf)) + 5000) / 10000);
 }
 
-static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
+static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk_khz;
 	u32 tHIGH, tLOW, tf;
@@ -236,6 +236,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	/* Get clock rate after clock is enabled */
 	clk_prepare_enable(pd->clk);
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
+	clk_disable_unprepare(pd->clk);
 	i2c_clk_khz /= pd->clks_per_count;
 
 	if (pd->bus_speed = STANDARD_MODE) {
@@ -249,7 +250,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	} else {
 		dev_err(pd->dev, "unrecognized bus speed %lu Hz\n",
 			pd->bus_speed);
-		goto out;
+		return -EINVAL;
 	}
 
 	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf);
@@ -266,8 +267,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	else
 		pd->icic &= ~ICIC_ICCHB8;
 
-out:
-	clk_disable_unprepare(pd->clk);
+	return 0;
 }
 
 static void activate_ch(struct sh_mobile_i2c_data *pd)
@@ -677,7 +677,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (resource_size(res) > 0x17)
 		pd->flags |= IIC_FLAG_HAS_ICIC67;
 
-	sh_mobile_i2c_init(pd);
+	ret = sh_mobile_i2c_init(pd);
+	if (ret)
+		return ret;
 
 	/* Enable Runtime PM for this device.
 	 *
-- 
1.9.2

