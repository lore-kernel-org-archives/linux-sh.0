From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 23 Apr 2015 08:29:09 +0000
Subject: [PATCH] i2c: mux: use proper dev when removing "channel-X" symlinks
Message-Id: <1429777749-15278-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Those symlinks are created for the mux_dev, so we need to remove it from
there. Currently, it breaks for muxes where the mux_dev is not the device
of the parent adapter like this:

[   78.234644] WARNING: CPU: 0 PID: 365 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x5c/0x78()
[   78.242438] sysfs: cannot create duplicate filename '/devices/platform/i2cbus@8/channel-0'

Remove confusing comments while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: c9449affad2ae0
---
 drivers/i2c/i2c-mux.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 593f7ca9adc783..06cc1ff088f12b 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -32,8 +32,9 @@ struct i2c_mux_priv {
 	struct i2c_algorithm algo;
 
 	struct i2c_adapter *parent;
-	void *mux_priv;	/* the mux chip/device */
-	u32  chan_id;	/* the channel id */
+	struct device *mux_dev;
+	void *mux_priv;
+	u32 chan_id;
 
 	int (*select)(struct i2c_adapter *, void *mux_priv, u32 chan_id);
 	int (*deselect)(struct i2c_adapter *, void *mux_priv, u32 chan_id);
@@ -119,6 +120,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 
 	/* Set up private adapter data */
 	priv->parent = parent;
+	priv->mux_dev = mux_dev;
 	priv->mux_priv = mux_priv;
 	priv->chan_id = chan_id;
 	priv->select = select;
@@ -203,7 +205,7 @@ void i2c_del_mux_adapter(struct i2c_adapter *adap)
 	char symlink_name[20];
 
 	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", priv->chan_id);
-	sysfs_remove_link(&adap->dev.parent->kobj, symlink_name);
+	sysfs_remove_link(&priv->mux_dev->kobj, symlink_name);
 
 	sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 	i2c_del_adapter(adap);
-- 
2.1.4

