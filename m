From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 14 May 2015 12:40:05 +0000
Subject: [PATCH 4/4] i2c: slave: add error messages to slave core
Message-Id: <1431607205-2316-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1431607205-2316-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Inform users what went wrong from the core, so drivers don't have to do
it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/i2c/i2c-core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124432c501..e4dfdde832aa5f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2914,18 +2914,24 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 {
 	int ret;
 
-	if (!client || !slave_cb)
+	if (!client || !slave_cb) {
+		dev_err(&client->dev, "%s: insufficent data\n", __func__);
 		return -EINVAL;
+	}
 
 	if (!(client->flags & I2C_CLIENT_TEN)) {
 		/* Enforce stricter address checking */
 		ret = i2c_check_addr_validity(client->addr);
-		if (ret)
+		if (ret) {
+			dev_err(&client->dev, "%s: invalid address\n", __func__);
 			return ret;
+		}
 	}
 
-	if (!client->adapter->algo->reg_slave)
+	if (!client->adapter->algo->reg_slave) {
+		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
 		return -EOPNOTSUPP;
+	}
 
 	client->slave_cb = slave_cb;
 
@@ -2933,8 +2939,10 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 	ret = client->adapter->algo->reg_slave(client);
 	i2c_unlock_adapter(client->adapter);
 
-	if (ret)
+	if (ret) {
 		client->slave_cb = NULL;
+		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
+	}
 
 	return ret;
 }
@@ -2944,8 +2952,10 @@ int i2c_slave_unregister(struct i2c_client *client)
 {
 	int ret;
 
-	if (!client->adapter->algo->unreg_slave)
+	if (!client->adapter->algo->unreg_slave) {
+		dev_err(&client->dev, "%s: not supported by adapter\n", __func__);
 		return -EOPNOTSUPP;
+	}
 
 	i2c_lock_adapter(client->adapter);
 	ret = client->adapter->algo->unreg_slave(client);
@@ -2953,6 +2963,8 @@ int i2c_slave_unregister(struct i2c_client *client)
 
 	if (ret = 0)
 		client->slave_cb = NULL;
+	else
+		dev_err(&client->dev, "%s: adapter returned error %d\n", __func__, ret);
 
 	return ret;
 }
-- 
2.1.4

