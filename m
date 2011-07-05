From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Jul 2011 09:38:09 +0000
Subject: [PATCH 4/5] sh: clock-sh7343: modify I2C clock settings
Message-Id: <87mxgtdq4h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C doesn't work without this patch on SH7343

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index 93c6460..a6d1348 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -195,6 +195,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -257,8 +258,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sio0", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("siof0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("siof1", &mstp_clks[MSTP001]),
-	CLKDEV_CON_ID("i2c0", &mstp_clks[MSTP109]),
-	CLKDEV_CON_ID("i2c1", &mstp_clks[MSTP108]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP109]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP108]),
 	CLKDEV_CON_ID("tpu0", &mstp_clks[MSTP225]),
 	CLKDEV_CON_ID("irda0", &mstp_clks[MSTP224]),
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
-- 
1.7.4.1

