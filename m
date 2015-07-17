From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 17 Jul 2015 14:08:27 +0000
Subject: [RFC 7/9] i2c: apply DT flags when probing
Message-Id: <1437142109-31975-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1437142109-31975-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1437142109-31975-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, linux-tegra@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Check for slave and 10-bit flags when probing and mark the client when
found. Improve the address validity check, too

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b5719a2cff97bf..4a92eded4ece9c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -27,6 +27,7 @@
    I2C slave support (c) 2014 by Wolfram Sang <wsa@sang-engineering.com>
  */
 
+#include <dt-bindings/i2c/i2c.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -1283,7 +1284,8 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	struct i2c_client *result;
 	struct i2c_board_info info = {};
 	struct dev_archdata dev_ad = {};
-	const __be32 *addr;
+	const __be32 *addr_be;
+	u32 addr;
 	int len;
 
 	dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
@@ -1294,20 +1296,31 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 		return ERR_PTR(-EINVAL);
 	}
 
-	addr = of_get_property(node, "reg", &len);
-	if (!addr || (len < sizeof(*addr))) {
+	addr_be = of_get_property(node, "reg", &len);
+	if (!addr_be || (len < sizeof(*addr_be))) {
 		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
 			node->full_name);
 		return ERR_PTR(-EINVAL);
 	}
 
-	info.addr = be32_to_cpup(addr);
-	if (info.addr > (1 << 10) - 1) {
+	addr = be32_to_cpup(addr_be);
+	if (addr & I2C_TEN_BIT_ADDRESS) {
+		addr &= ~I2C_TEN_BIT_ADDRESS;
+		info.flags |= I2C_CLIENT_TEN;
+	}
+
+	if (addr & I2C_OWN_SLAVE_ADDRESS) {
+		addr &= ~I2C_OWN_SLAVE_ADDRESS;
+		info.flags |= I2C_CLIENT_SLAVE;
+	}
+
+	if (i2c_check_addr_validity(addr, info.flags)) {
 		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
 			info.addr, node->full_name);
 		return ERR_PTR(-EINVAL);
 	}
 
+	info.addr = addr;
 	info.of_node = of_node_get(node);
 	info.archdata = &dev_ad;
 
-- 
2.1.4

