From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:15 +0000
Subject: [PATCH v2 09/10] i2c: sh_mobile: check timing parameters for valid range
Message-Id: <1399058116-7721-10-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Due to misconfiguration, it can happen that the calculated timing
parameters are out of range. Bail out if that happens. We can also
simplify some logic later because of the verified value. Also, make the
printouts of the values more precise by adding the hex-prefixes.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9f02013eaeeb..b1d399e3e5fc 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -232,6 +232,7 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk_khz;
 	u32 tHIGH, tLOW, tf;
+	uint16_t max_val;
 
 	/* Get clock rate after clock is enabled */
 	clk_prepare_enable(pd->clk);
@@ -254,15 +255,23 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	}
 
 	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf);
+	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf);
+
+	max_val = pd->flags & IIC_FLAG_HAS_ICIC67 ? 0x1ff : 0xff;
+	if (pd->iccl > max_val || pd->icch > max_val) {
+		dev_err(pd->dev, "timing values out of range: L/H=0x%x/0x%x\n",
+			pd->iccl, pd->icch);
+		return -EINVAL;
+	}
+
 	/* one more bit of ICCL in ICIC */
-	if ((pd->iccl > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
+	if (pd->iccl & 0x100)
 		pd->icic |= ICIC_ICCLB8;
 	else
 		pd->icic &= ~ICIC_ICCLB8;
 
-	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf);
 	/* one more bit of ICCH in ICIC */
-	if ((pd->icch > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
+	if (pd->icch & 0x100)
 		pd->icic |= ICIC_ICCHB8;
 	else
 		pd->icic &= ~ICIC_ICCHB8;
@@ -717,7 +726,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	}
 
 	dev_info(&dev->dev,
-		 "I2C adapter %d with bus speed %lu Hz (L/H=%x/%x)\n",
+		 "I2C adapter %d with bus speed %lu Hz (L/H=0x%x/0x%x)\n",
 		 adap->nr, pd->bus_speed, pd->iccl, pd->icch);
 
 	return 0;
-- 
1.9.2

