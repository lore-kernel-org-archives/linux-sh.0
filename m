From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Apr 2011 13:20:39 +0000
Subject: [PATCH] i2c: i2c-sh_mobile clock string removal
Message-Id: <20110421132039.3717.13185.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, ben-linux@fluff.org, khali@linux-fr.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Remove the clock string magic from the i2c-sh_mobile driver
now when all platforms support clkdev properly.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/i2c/busses/i2c-sh_mobile.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- 0005/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2011-04-21 19:53:51.000000000 +0900
@@ -577,7 +577,6 @@ static int sh_mobile_i2c_probe(struct pl
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
-	char clk_name[8];
 	int size;
 	int ret;
 
@@ -587,10 +586,9 @@ static int sh_mobile_i2c_probe(struct pl
 		return -ENOMEM;
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "i2c%d", dev->id);
-	pd->clk = clk_get(&dev->dev, clk_name);
+	pd->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(pd->clk)) {
-		dev_err(&dev->dev, "cannot get clock \"%s\"\n", clk_name);
+		dev_err(&dev->dev, "cannot get clock\n");
 		ret = PTR_ERR(pd->clk);
 		goto err;
 	}
