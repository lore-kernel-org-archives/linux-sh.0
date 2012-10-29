From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Oct 2012 08:14:41 +0000
Subject: [PATCH 2/7] ARM: shmobile: r8a7740: add USB24 clock explain
Message-Id: <87ip9t4rv5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USBCKCR is controlling USB parent clock and divide rate.
This parent clock is used as a "usb24s" from other devices,
but the "divide rate" is not used.
Further, this clock itself is known as "usb24".
So, to set this clock is a little confusable.
This patch adds quick explain and sample settings for this clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 6729e00..c012bbf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -188,6 +188,22 @@ static struct clk pllc1_div2_clk = {
 };
 
 /* USB clock */
+/*
+ * USBCKCR is controlling usb24 clock
+ * bit[7] : parent clock
+ * bit[6] : clock divide rate
+ * And this bit[7] is used as a "usb24s" from other devices.
+ * (Video clock / Sub clock / SPU clock)
+ * You can controll this clock as a below.
+ *
+ * struct clk *usb24	= clk_get(dev,  "usb24");
+ * struct clk *usb24s	= clk_get(NULL, "usb24s");
+ * struct clk *system	= clk_get(NULL, "system_clk");
+ * int rate = clk_get_rate(system);
+ *
+ * clk_set_parent(usb24s, system);  // for bit[7]
+ * clk_set_rate(usb24, rate / 2);   // for bit[6]
+ */
 static struct clk *usb24s_parents[] = {
 	[0] = &system_clk,
 	[1] = &extal2_clk
-- 
1.7.9.5

