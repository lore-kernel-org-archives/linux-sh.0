From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Jul 2011 09:38:21 +0000
Subject: [PATCH 5/5] sh: clock-sh7366: modify I2C clock settings
Message-Id: <87liwddq45.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C doesn't work without this patch on SH7366

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 049dc06..bddfe01 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -193,6 +193,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -249,7 +250,7 @@ static struct clk_lookup lookups[] = {
 	},
 	CLKDEV_CON_ID("msiof0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("sbr0", &mstp_clks[MSTP001]),
-	CLKDEV_CON_ID("i2c0", &mstp_clks[MSTP109]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP109]),
 	CLKDEV_CON_ID("icb0", &mstp_clks[MSTP227]),
 	CLKDEV_CON_ID("meram0", &mstp_clks[MSTP226]),
 	CLKDEV_CON_ID("dacy1", &mstp_clks[MSTP224]),
-- 
1.7.4.1

