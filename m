From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Dec 2013 04:15:24 +0000
Subject: [PATCH] arm: shmobile: r7s72100: really add i2c clocks
Message-Id: <1388117724-11103-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Due to a merge conflict, addition of the clocks was lost. Tested with
RIIC2 on a genmai board. Others untested but hopefully trivial enough to
be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index e6ab0cd..dd8ce87 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -176,6 +176,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */
-- 
1.8.5.1

