From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 May 2012 01:12:41 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s
Message-Id: <87y5p423qy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201204252313.23899.rjw@sisk.pl>
In-Reply-To: <201204252313.23899.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the clocks is always same value as the parent clock,
we can use followparent_recalc() for .recalc

Reported-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 89a2f9d..81b54a6 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -188,11 +188,6 @@ static struct clk *usb24s_parents[] = {
 	[1] = &extal2_clk
 };
 
-static unsigned long usb24s_recalc(struct clk *clk)
-{
-	return clk->parent->rate;
-};
-
 static int usb24s_enable(struct clk *clk)
 {
 	__raw_writel(__raw_readl(USBCKCR) & ~(1 << 8), USBCKCR);
@@ -234,7 +229,7 @@ static int usb24s_set_parent(struct clk *clk, struct clk *parent)
 }
 
 static struct sh_clk_ops usb24s_clk_ops = {
-	.recalc		= usb24s_recalc,
+	.recalc		= followparent_recalc,
 	.enable		= usb24s_enable,
 	.disable	= usb24s_disable,
 	.set_parent	= usb24s_set_parent,
-- 
1.7.5.4

