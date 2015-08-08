From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:26 +0000
Subject: [PATCH 09/10] i2c: slave: print warning if slave flag not set
Message-Id: <1439066007-13951-10-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Address collisions will be rare, but we should let the user know that
slaves have their own address space nonetheless.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 4c1f31f039964b..4d143fe7c3eab3 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2980,6 +2980,10 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 		return -EINVAL;
 	}
 
+	if (!(client->flags & I2C_CLIENT_SLAVE))
+		dev_warn(&client->dev, "%s: client slave flag not set. You might see address collisions\n",
+			 __func__);
+
 	if (!(client->flags & I2C_CLIENT_TEN)) {
 		/* Enforce stricter address checking */
 		ret = i2c_check_7bit_addr_validity_strict(client->addr);
-- 
2.1.4

