From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:41 +0000
Subject: [RFC/PATCH 1/6] sh: Rename sci_ick clock to sci_fck
Message-Id: <1398817906-6023-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SCI driver requires an interface clock and handles an optional
functional clock. When a clock named "sci_ick" exists that clock is used
as the interface clock, otherwise the driver falls back to a clock
called "peripheral_clk".

Most SH platforms define an "sci_fck" functional clock without any
"sci_ick" interface clock, relying on the driver fallback code. In
preparation for dropping the interface clock from the SCI driver, rename
the sci_ick clock to sci_fck in for the SH platforms that define
sci_ick. The driver will correctly fallback on the peripheral_clk clock
on those platforms.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/clock-cpg.c         | 2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index f59b1f3..4f1d5e8 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -59,7 +59,7 @@ int __init __deprecated cpg_clk_init(void)
 	clk_add_alias("tmu_fck", NULL, "peripheral_clk", NULL);
 	clk_add_alias("mtu2_fck", NULL, "peripheral_clk", NULL);
 	clk_add_alias("cmt_fck", NULL, "peripheral_clk", NULL);
-	clk_add_alias("sci_ick", NULL, "peripheral_clk", NULL);
+	clk_add_alias("sci_fck", NULL, "peripheral_clk", NULL);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
index fdf585c..bb05e3b 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
@@ -115,7 +115,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
 
 	/* MSTP clocks */
-	CLKDEV_CON_ID("sci_ick", &mstp_clks[MSTP77]),
+	CLKDEV_CON_ID("sci_fck", &mstp_clks[MSTP77]),
 	CLKDEV_CON_ID("vdc3", &mstp_clks[MSTP74]),
 	CLKDEV_CON_ID("cmt_fck", &mstp_clks[MSTP72]),
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP60]),
-- 
1.8.3.2

