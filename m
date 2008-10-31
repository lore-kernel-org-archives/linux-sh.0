From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:20:55 +0000
Subject: [PATCH] sh: sh_mobile i2c clock framework support
Message-Id: <20081031112055.2987.62301.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the sh_mobile i2c driver and
adjust the processor specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |    4 -
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    2 
 drivers/i2c/busses/i2c-sh_mobile.c     |   73 +++++++++++++++-----------------
 5 files changed, 41 insertions(+), 42 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-10-31 19:12:42.000000000 +0900
@@ -30,6 +30,7 @@ static struct resource iic0_resources[] 
 
 static struct platform_device iic0_device = {
 	.name           = "i2c-sh_mobile",
+	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic0_resources),
 	.resource       = iic0_resources,
 };
@@ -50,6 +51,7 @@ static struct resource iic1_resources[] 
 
 static struct platform_device iic1_device = {
 	.name           = "i2c-sh_mobile",
+	.id             = 1, /* "i2c1" clock */
 	.num_resources  = ARRAY_SIZE(iic1_resources),
 	.resource       = iic1_resources,
 };
@@ -147,8 +149,6 @@ static int __init sh7343_devices_setup(v
 	clk_always_enable("mstp023"); /* INTC3 */
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp109"); /* I2C0 */
-	clk_always_enable("mstp108"); /* I2C1 */
 	clk_always_enable("mstp202"); /* VEU */
 	clk_always_enable("mstp201"); /* VPU */
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-10-31 19:14:04.000000000 +0900
@@ -32,6 +32,7 @@ static struct resource iic_resources[]  
 static struct platform_device iic_device = {
 	.name           = "i2c-sh_mobile",
+	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
 };
@@ -184,7 +185,6 @@ static int __init sh7366_devices_setup(v
 	clk_always_enable("mstp023"); /* INTC3 */
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp109"); /* I2C */
 	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp207"); /* VEU-2 */
 	clk_always_enable("mstp202"); /* VEU-1 */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-10-31 19:12:42.000000000 +0900
@@ -87,6 +87,7 @@ static struct resource iic_resources[]  
 static struct platform_device iic_device = {
 	.name           = "i2c-sh_mobile",
+	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
 };
@@ -197,7 +198,6 @@ static int __init sh7722_devices_setup(v
 	clk_always_enable("mstp026"); /* XYMEM */
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp109"); /* I2C */
 	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp202"); /* VEU */
 	clk_always_enable("mstp201"); /* VPU */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-10-31 19:12:42.000000000 +0900
@@ -215,6 +215,7 @@ static struct resource iic_resources[]  
 static struct platform_device iic_device = {
 	.name           = "i2c-sh_mobile",
+	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
 };
@@ -238,7 +239,6 @@ static int __init sh7723_devices_setup(v
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
 	clk_always_enable("mstp000"); /* MERAM */
-	clk_always_enable("mstp109"); /* I2C */
 	clk_always_enable("mstp108"); /* RTC */
 	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp206"); /* VEU2H1 */
--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2008-10-31 19:12:42.000000000 +0900
@@ -160,9 +160,39 @@ struct sh_mobile_i2c_data {
 
 static void activate_ch(struct sh_mobile_i2c_data *pd)
 {
+	unsigned long i2c_clk;
+	u_int32_t num;
+	u_int32_t denom;
+	u_int32_t tmp;
+
 	/* Make sure the clock is enabled */
 	clk_enable(pd->clk);
 
+	/* Get clock rate after clock is enabled */
+	i2c_clk = clk_get_rate(pd->clk);
+
+	/* Calculate the value for iccl. From the data sheet:
+	 * iccl = (p clock / transfer rate) * (L / (L + H))
+	 * where L and H are the SCL low/high ratio (5/4 in this case).
+	 * We also round off the result.
+	 */
+	num = i2c_clk * 5;
+	denom = NORMAL_SPEED * 9;
+	tmp = num * 10 / denom;
+	if (tmp % 10 >= 5)
+		pd->iccl = (u_int8_t)((num/denom) + 1);
+	else
+		pd->iccl = (u_int8_t)(num/denom);
+
+	/* Calculate the value for icch. From the data sheet:
+	   icch = (p clock / transfer rate) * (H / (L + H)) */
+	num = i2c_clk * 4;
+	tmp = num * 10 / denom;
+	if (tmp % 10 >= 5)
+		pd->icch = (u_int8_t)((num/denom) + 1);
+	else
+		pd->icch = (u_int8_t)(num/denom);
+
 	/* Enable channel and configure rx ack */
 	iowrite8(ioread8(ICCR(pd)) | ICCR_ICE, ICCR(pd));
 
@@ -458,40 +488,6 @@ static struct i2c_algorithm sh_mobile_i2
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
-static void sh_mobile_i2c_setup_channel(struct platform_device *dev)
-{
-	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
-	unsigned long peripheral_clk = clk_get_rate(pd->clk);
-	u_int32_t num;
-	u_int32_t denom;
-	u_int32_t tmp;
-
-	spin_lock_init(&pd->lock);
-	init_waitqueue_head(&pd->wait);
-
-	/* Calculate the value for iccl. From the data sheet:
-	 * iccl = (p clock / transfer rate) * (L / (L + H))
-	 * where L and H are the SCL low/high ratio (5/4 in this case).
-	 * We also round off the result.
-	 */
-	num = peripheral_clk * 5;
-	denom = NORMAL_SPEED * 9;
-	tmp = num * 10 / denom;
-	if (tmp % 10 >= 5)
-		pd->iccl = (u_int8_t)((num/denom) + 1);
-	else
-		pd->iccl = (u_int8_t)(num/denom);
-
-	/* Calculate the value for icch. From the data sheet:
-	   icch = (p clock / transfer rate) * (H / (L + H)) */
-	num = peripheral_clk * 4;
-	tmp = num * 10 / denom;
-	if (tmp % 10 >= 5)
-		pd->icch = (u_int8_t)((num/denom) + 1);
-	else
-		pd->icch = (u_int8_t)(num/denom);
-}
-
 static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
 {
 	struct resource *res;
@@ -532,6 +528,7 @@ static int sh_mobile_i2c_probe(struct pl
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
+	char clk_name[8];
 	int size;
 	int ret;
 
@@ -541,9 +538,10 @@ static int sh_mobile_i2c_probe(struct pl
 		return -ENOMEM;
 	}
 
-	pd->clk = clk_get(&dev->dev, "peripheral_clk");
+	snprintf(clk_name, sizeof(clk_name), "i2c%d", dev->id);
+	pd->clk = clk_get(&dev->dev, clk_name);
 	if (IS_ERR(pd->clk)) {
-		dev_err(&dev->dev, "cannot get peripheral clock\n");
+		dev_err(&dev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(pd->clk);
 		goto err;
 	}
@@ -585,7 +583,8 @@ static int sh_mobile_i2c_probe(struct pl
 
 	strlcpy(adap->name, dev->name, sizeof(adap->name));
 
-	sh_mobile_i2c_setup_channel(dev);
+	spin_lock_init(&pd->lock);
+	init_waitqueue_head(&pd->wait);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
