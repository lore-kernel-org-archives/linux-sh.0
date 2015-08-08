From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:20 +0000
Subject: [PATCH 03/10] i2c: apply address offset for slaves, too
Message-Id: <1439066007-13951-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want a separate address range for being an I2C slave. Add an offset
of 0x1000, so it can be combined with ten bit addresses as well. Add a
separate function to create the address value, we will need it later in
other places.

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e6d4935161e490..150ee00b5ff5cb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -57,6 +57,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/i2c.h>
 
+#define I2C_ADDR_OFFSET_TEN_BIT	0xa000
+#define I2C_ADDR_OFFSET_SLAVE	0x1000
+
 /* core_lock protects i2c_adapter_idr, and guarantees
    that device detection, deletion of detected devices, and attach_adapter
    calls are serialized */
@@ -776,6 +779,21 @@ struct i2c_client *i2c_verify_client(struct device *dev)
 EXPORT_SYMBOL(i2c_verify_client);
 
 
+/* Return a unique address which takes the flags of the client into account */
+static unsigned short i2c_encode_flags_to_addr(struct i2c_client *client)
+{
+	unsigned short addr = client->addr;
+
+	/* For some client flags, add an arbitrary offset to avoid collisions */
+	if (client->flags & I2C_CLIENT_TEN)
+		addr |= I2C_ADDR_OFFSET_TEN_BIT;
+
+	if (client->flags & I2C_CLIENT_SLAVE)
+		addr |= I2C_ADDR_OFFSET_SLAVE;
+
+	return addr;
+}
+
 /* This is a permissive address validity check, I2C address map constraints
  * are purposely not enforced, except for the general call address. */
 static int i2c_check_client_addr_validity(const struct i2c_client *client)
@@ -921,10 +939,8 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
 		return;
 	}
 
-	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr | ((client->flags & I2C_CLIENT_TEN)
-				     ? 0xa000 : 0));
+		     i2c_encode_flags_to_addr(client));
 }
 
 /**
-- 
2.1.4

