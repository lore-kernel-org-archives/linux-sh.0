From: Bastian Hecht <hechtb@gmail.com>
Date: Sat, 12 Jul 2014 11:49:31 +0000
Subject: [PATCH 5/5] i2c: tegra: Remove suspension check
Message-Id: <1405165771-8732-5-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1405165771-8732-1-git-send-email-hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Taekgyun Ko <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

We now take care of suspension in the i2c core code. So we can remove this
check here.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index f1bb2fc..c279d85 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -172,7 +172,6 @@ struct tegra_i2c_dev {
 	size_t msg_buf_remaining;
 	int msg_read;
 	u32 bus_clk_rate;
-	bool is_suspended;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned long reg)
@@ -628,9 +627,6 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int i;
 	int ret = 0;
 
-	if (i2c_dev->is_suspended)
-		return -EBUSY;
-
 	ret = tegra_i2c_clock_enable(i2c_dev);
 	if (ret < 0) {
 		dev_err(i2c_dev->dev, "Clock enable failed %d\n", ret);
@@ -817,17 +813,6 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra_i2c_suspend(struct device *dev)
-{
-	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-
-	i2c_lock_adapter(&i2c_dev->adapter);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
-
-	return 0;
-}
-
 static int tegra_i2c_resume(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
@@ -842,14 +827,12 @@ static int tegra_i2c_resume(struct device *dev)
 		return ret;
 	}
 
-	i2c_dev->is_suspended = false;
-
 	i2c_unlock_adapter(&i2c_dev->adapter);
 
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
+static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_resume);
 #define TEGRA_I2C_PM	(&tegra_i2c_pm)
 #else
 #define TEGRA_I2C_PM	NULL
-- 
1.9.1

