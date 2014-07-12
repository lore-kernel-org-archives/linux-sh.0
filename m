From: Bastian Hecht <hechtb@gmail.com>
Date: Sat, 12 Jul 2014 11:49:27 +0000
Subject: [PATCH 1/5] i2c: Don't start transfers when suspended
Message-Id: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Taekgyun Ko <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

i2c transfer requests come in very uncontrolled, like from interrupt routines.
We might be suspended when this happens. To avoid i2c timeouts caused by
powered down busses we check for suspension.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
I ended up getting i2c timeouts when suspending and provoking touchscreen
IRQs on an Armadillo board with an sh_mobile i2c bus. Instead of copying
again the protection mechanism from other bus drivers, we can clean things
up and move this into the core.

I assume that all bus drivers use kzalloc or equivalent for the
struct i2c_adapter. So adap->suspended can't end up uninitialized,
right?

We could consider using this scheme for freeze/restore too.


 drivers/i2c/i2c-core.c | 24 +++++++++++++++++++++++-
 include/linux/i2c.h    |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7c7f4b8..9fe9581 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -343,6 +343,13 @@ static int i2c_legacy_resume(struct device *dev)
 static int i2c_device_pm_suspend(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	struct i2c_adapter *adap = i2c_verify_adapter(dev);
+
+	if (adap) {
+		i2c_lock_adapter(adap);
+		adap->suspended = true;
+		i2c_unlock_adapter(adap);
+	}
 
 	if (pm)
 		return pm_generic_suspend(dev);
@@ -353,6 +360,13 @@ static int i2c_device_pm_suspend(struct device *dev)
 static int i2c_device_pm_resume(struct device *dev)
 {
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	struct i2c_adapter *adap = i2c_verify_adapter(dev);
+
+	if (adap) {
+		i2c_lock_adapter(adap);
+		adap->suspended = false;
+		i2c_unlock_adapter(adap);
+	}
 
 	if (pm)
 		return pm_generic_resume(dev);
@@ -1819,7 +1833,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			i2c_lock_adapter(adap);
 		}
 
-		ret = __i2c_transfer(adap, msgs, num);
+		if (adap->suspended)
+			ret = -EIO;
+		else
+			ret = __i2c_transfer(adap, msgs, num);
 		i2c_unlock_adapter(adap);
 
 		return ret;
@@ -2577,6 +2594,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 
 	if (adapter->algo->smbus_xfer) {
 		i2c_lock_adapter(adapter);
+		if (adapter->suspended) {
+			res = -EIO;
+			goto unlock;
+		}
 
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
@@ -2590,6 +2611,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
+unlock:
 		i2c_unlock_adapter(adapter);
 
 		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b556e0a..af08c75 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -434,6 +434,7 @@ struct i2c_adapter {
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
+	unsigned int suspended:1;
 
 	int nr;
 	char name[48];
-- 
1.9.1

