From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Jul 2011 09:37:55 +0000
Subject: [PATCH 3/5] sh: clock-sh7723: modify I2C clock settings
Message-Id: <87oc19dq4v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C doesn't work without this patch on SH7723

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index 55493cd..7f70899 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -201,6 +201,7 @@ static struct clk mstp_clks[] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -305,7 +306,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("msiof0", &mstp_clks[HWBLK_MSIOF0]),
 	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
 	CLKDEV_CON_ID("meram0", &mstp_clks[HWBLK_MERAM]),
-	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
 	CLKDEV_CON_ID("atapi0", &mstp_clks[HWBLK_ATAPI]),
 	CLKDEV_CON_ID("adc0", &mstp_clks[HWBLK_ADC]),
-- 
1.7.4.1

