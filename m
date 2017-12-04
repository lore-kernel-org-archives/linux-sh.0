From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 04 Dec 2017 14:30:49 +0000
Subject: [PATCH] arch/sh: fix Ethernet clock for SH7786
Message-Id: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_eth driver (used for the Ethernet controller on SH7786) uses
devm_clk_get(&pdev->dev, NULL) to get its clock. It means that con_id
= NULL, and therefore a clock lookup made on the con_id doesn't work.

In order to make sure that the sh_eth driver is able to find its clock
on SH7786, we switch from using a con_id to a dev_id in the clock
lookup table for this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index ac3dcfe5d303..fa183280a62c 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -170,7 +170,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
 	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
 	CLKDEV_CON_ID("du_fck", &mstp_clks[MSTP103]),
-	CLKDEV_CON_ID("ether_fck", &mstp_clks[MSTP102]),
+	CLKDEV_DEV_ID("sh7786-ether.0", &mstp_clks[MSTP102]),
 };
 
 int __init arch_clk_init(void)
-- 
2.13.6

