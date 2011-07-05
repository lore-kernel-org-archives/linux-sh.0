From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Jul 2011 09:37:33 +0000
Subject: [PATCH 2/5] sh: clock-sh7722: modify I2C clock settings
Message-Id: <87pqlpdq5g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C doesn't work without this patch on SH7722

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 9d23a36..e0e80d2 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -176,6 +176,7 @@ static struct clk mstp_clks[HWBLK_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -236,7 +237,7 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "sci_fck",
 		.clk		= &mstp_clks[HWBLK_SCIF2],
 	},
-	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI]),
 	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
-- 
1.7.4.1

