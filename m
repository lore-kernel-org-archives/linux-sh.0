From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 08 Aug 2012 08:55:28 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: add USB24 clock explain and sample code
Message-Id: <87y5lpn4oz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USBCKCR is controlling USB parent clock and divide rate.
This parent clock is used as a "usb24s" from other devices,
but the "divide rate" is not used.
Further, this clock itself is known as "usb24".
So, to set this clock is a little confusable.
This patch adds quick explain and sample code for this clock.

Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index ad5fccc..a6a7583 100644
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
1.7.5.4

