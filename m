From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:09 +0000
Subject: [PATCH v2 03/10] i2c: sh_mobile: honor DT bus speed settings
Message-Id: <1399058116-7721-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index d2fa222df3d1..2e481abd50ce 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -657,6 +657,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	struct resource *res;
 	int size;
 	int ret;
+	u32 bus_speed;
 
 	pd = kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
 	if (pd = NULL) {
@@ -697,7 +698,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	}
 
 	/* Use platform data bus speed or STANDARD_MODE */
-	pd->bus_speed = STANDARD_MODE;
+	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
+	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
+
 	if (pdata && pdata->bus_speed)
 		pd->bus_speed = pdata->bus_speed;
 	pd->clks_per_count = 1;
-- 
1.9.2

