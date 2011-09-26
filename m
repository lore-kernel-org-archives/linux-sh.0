From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 26 Sep 2011 08:41:28 +0000
Subject: [PATCH] sh: add parameters for EHCI and RIIC in clock-sh7757.c
Message-Id: <4E803AB8.6020909@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 3b097b0..19222da 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -113,7 +113,14 @@ static struct clk_lookup lookups[] = {

 	/* MSTP32 clocks */
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP004]),
-	CLKDEV_CON_ID("riic", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic0", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic1", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic2", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic3", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic4", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic5", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic6", &mstp_clks[MSTP000]),
+	CLKDEV_CON_ID("riic7", &mstp_clks[MSTP000]),

 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP113]),
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP114]),
@@ -121,6 +128,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP111]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP110]),

+	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP102]),
 	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
 };
-- 
1.7.1
