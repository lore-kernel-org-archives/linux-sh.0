From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:23 +0000
Subject: [PATCH 4/5] [DEBUG] clk/mstp: Monitor MSTP clock enable/disable
Message-Id: <1397565924-23541-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-mstp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 4f5e2c6ec853..2e3c08fff173 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/spinlock.h>
+#include <linux/clk-private.h>
 
 /*
  * MSTP clocks. We can't use standard gate clocks as we need to poll on the
@@ -62,6 +63,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 	unsigned int i;
 	u32 value;
 
+pr_info("MSTP %s %s\n", hw->clk->name, enable ? "ON" : "OFF");
 	spin_lock_irqsave(&group->lock, flags);
 
 	value = clk_readl(group->smstpcr);
@@ -150,6 +152,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
 	if (IS_ERR(clk))
 		kfree(clock);
 
+//pr_info("%s: clk_register %p name %s parent %s\n", __func__, clk, name, parent_name);
 	return clk;
 }
 
@@ -221,6 +224,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			 * FIXME: Remove this when all devices that require a
 			 * clock will be instantiated from DT.
 			 */
+//pr_info("%s: clk_register_clkdev %p con_id %s\n", __func__, clks[clkidx], name);
 			clk_register_clkdev(clks[clkidx], name, NULL);
 		} else {
 			pr_err("%s: failed to register %s %s clock (%ld)\n",
-- 
1.7.9.5

