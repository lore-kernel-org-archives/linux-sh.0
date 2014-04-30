From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 22:21:07 +0000
Subject: [PATCH 3/6] i2c: sh_mobile: honor DT bus speed settings
Message-Id: <1398896470-24663-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

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

