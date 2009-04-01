From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:49:41 +0000
Subject: [PATCH] migor_ts: add wakeup support
Message-Id: <20090401144941.385.70861.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add wakeup support to the migor_ts driver. If user space has enabled
wakeup, use set_irq_wake() during suspend and resume. With this patch
the migor_ts driver can be used to wake the system from suspend.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested with wakeup enabled and disabled on a Migo-R board.

 drivers/input/touchscreen/migor_ts.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- 0001/drivers/input/touchscreen/migor_ts.c
+++ work/drivers/input/touchscreen/migor_ts.c	2009-04-01 22:59:07.000000000 +0900
@@ -198,6 +198,7 @@ static int migor_ts_probe(struct i2c_cli
 		goto err2;
 	}
 
+	device_init_wakeup(&client->dev, 1);
 	return 0;
 
  err2:
@@ -224,6 +225,26 @@ static int migor_ts_remove(struct i2c_cl
 	return 0;
 }
 
+static int migor_ts_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static int migor_ts_resume(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(priv->irq);
+
+	return 0;
+}
+
 static const struct i2c_device_id migor_ts_id[] = {
 	{ "migor_ts", 0 },
 	{ }
@@ -236,6 +257,8 @@ static struct i2c_driver migor_ts_driver
 	},
 	.probe = migor_ts_probe,
 	.remove = migor_ts_remove,
+	.suspend = migor_ts_suspend,
+	.resume = migor_ts_resume,
 	.id_table = migor_ts_id,
 };
 
