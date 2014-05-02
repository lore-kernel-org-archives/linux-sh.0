From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:13 +0000
Subject: [PATCH v2 07/10] i2c: sh_mobile: remove superfluous offset parameter
Message-Id: <1399058116-7721-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Following the KISS principle, remove unneeded stuff.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index ddc9970fd724..9a5b693454e1 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -194,7 +194,7 @@ static void iic_set_clr(struct sh_mobile_i2c_data *pd, int offs,
 	iic_wr(pd, offs, (iic_rd(pd, offs) | set) & ~clr);
 }
 
-static u32 sh_mobile_i2c_iccl(unsigned long count_khz, u32 tLOW, u32 tf, int offset)
+static u32 sh_mobile_i2c_iccl(unsigned long count_khz, u32 tLOW, u32 tf)
 {
 	/*
 	 * Conditional expression:
@@ -206,10 +206,10 @@ static u32 sh_mobile_i2c_iccl(unsigned long count_khz, u32 tLOW, u32 tf, int off
 	 * account the fall time of SCL signal (tf).  Default tf value
 	 * should be 0.3 us, for safety.
 	 */
-	return (((count_khz * (tLOW + tf)) + 5000) / 10000) + offset;
+	return (((count_khz * (tLOW + tf)) + 5000) / 10000);
 }
 
-static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf, int offset)
+static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf)
 {
 	/*
 	 * Conditional expression:
@@ -225,14 +225,13 @@ static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf, int of
 	 * to take into account the fall time of SDA signal (tf) at START
 	 * condition, in order to meet both tHIGH and tHD;STA specs.
 	 */
-	return (((count_khz * (tHIGH + tf)) + 5000) / 10000) + offset;
+	return (((count_khz * (tHIGH + tf)) + 5000) / 10000);
 }
 
 static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk_khz;
 	u32 tHIGH, tLOW, tf;
-	int offset;
 
 	/* Get clock rate after clock is enabled */
 	clk_prepare_enable(pd->clk);
@@ -243,26 +242,24 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 		tLOW	= 47;	/* tLOW = 4.7 us */
 		tHIGH	= 40;	/* tHD;STA = tHIGH = 4.0 us */
 		tf	= 3;	/* tf = 0.3 us */
-		offset	= 0;	/* No offset */
 	} else if (pd->bus_speed = FAST_MODE) {
 		tLOW	= 13;	/* tLOW = 1.3 us */
 		tHIGH	= 6;	/* tHD;STA = tHIGH = 0.6 us */
 		tf	= 3;	/* tf = 0.3 us */
-		offset	= 0;	/* No offset */
 	} else {
 		dev_err(pd->dev, "unrecognized bus speed %lu Hz\n",
 			pd->bus_speed);
 		goto out;
 	}
 
-	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf, offset);
+	pd->iccl = sh_mobile_i2c_iccl(i2c_clk_khz, tLOW, tf);
 	/* one more bit of ICCL in ICIC */
 	if ((pd->iccl > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
 		pd->icic |= ICIC_ICCLB8;
 	else
 		pd->icic &= ~ICIC_ICCLB8;
 
-	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf, offset);
+	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf);
 	/* one more bit of ICCH in ICIC */
 	if ((pd->icch > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
 		pd->icic |= ICIC_ICCHB8;
-- 
1.9.2

