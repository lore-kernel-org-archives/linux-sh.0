From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Jul 2011 09:37:02 +0000
Subject: [PATCH 1/5] sh: clock-sh7724: modify I2C clock settings
Message-Id: <87r565dq6c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C doesn't work without this patch on SH7724

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index d08fa95..77bcef5 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -253,6 +253,7 @@ static struct clk mstp_clks[HWBLK_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -358,8 +359,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
 	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
-	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC0]),
-	CLKDEV_CON_ID("i2c1", &mstp_clks[HWBLK_IIC1]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC0]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[HWBLK_IIC1]),
 	CLKDEV_CON_ID("mmc0", &mstp_clks[HWBLK_MMC]),
 	CLKDEV_CON_ID("eth0", &mstp_clks[HWBLK_ETHER]),
 	CLKDEV_CON_ID("atapi0", &mstp_clks[HWBLK_ATAPI]),
-- 
1.7.4.1

