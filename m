From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 03:09:20 +0000
Subject: [PATCH 5/8] ARM: shmobile: use FSI driver's audio clock on mackerel
Message-Id: <87y5iczt7m.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current FSI driver can control audio clock without platform
call-back functions
This patch removed board-specific call-back/settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   72 +------------------------------
 1 file changed, 1 insertion(+), 71 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d5fe365..bf2bcb9 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -862,76 +862,6 @@ static struct platform_device leds_device = {
 
 /* FSI */
 #define IRQ_FSI evt2irq(0x1840)
-static int __fsi_set_round_rate(struct clk *clk, long rate, int enable)
-{
-	int ret;
-
-	if (rate <= 0)
-		return 0;
-
-	if (!enable) {
-		clk_disable(clk);
-		return 0;
-	}
-
-	ret = clk_set_rate(clk, clk_round_rate(clk, rate));
-	if (ret < 0)
-		return ret;
-
-	return clk_enable(clk);
-}
-
-static int fsi_b_set_rate(struct device *dev, int rate, int enable)
-{
-	struct clk *fsib_clk;
-	struct clk *fdiv_clk = clk_get(NULL, "fsidivb");
-	long fsib_rate = 0;
-	long fdiv_rate = 0;
-	int ackmd_bpfmd;
-	int ret;
-
-	/* clock start */
-	switch (rate) {
-	case 44100:
-		fsib_rate	= rate * 256;
-		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
-		break;
-	case 48000:
-		fsib_rate	= 85428000; /* around 48kHz x 256 x 7 */
-		fdiv_rate	= rate * 256;
-		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
-		break;
-	default:
-		pr_err("unsupported rate in FSI2 port B\n");
-		return -EINVAL;
-	}
-
-	/* FSI B setting */
-	fsib_clk = clk_get(dev, "ickb");
-	if (IS_ERR(fsib_clk))
-		return -EIO;
-
-	/* fsib */
-	ret = __fsi_set_round_rate(fsib_clk, fsib_rate, enable);
-	if (ret < 0)
-		goto fsi_set_rate_end;
-
-	/* FSI DIV */
-	ret = __fsi_set_round_rate(fdiv_clk, fdiv_rate, enable);
-	if (ret < 0) {
-		/* disable FSI B */
-		if (enable)
-			__fsi_set_round_rate(fsib_clk, fsib_rate, 0);
-		goto fsi_set_rate_end;
-	}
-
-	ret = ackmd_bpfmd;
-
-fsi_set_rate_end:
-	clk_put(fsib_clk);
-	return ret;
-}
-
 static struct sh_fsi_platform_info fsi_info = {
 	.port_a = {
 		.flags = SH_FSI_BRS_INV,
@@ -942,8 +872,8 @@ static struct sh_fsi_platform_info fsi_info = {
 		.flags = SH_FSI_BRS_INV	|
 			SH_FSI_BRM_INV	|
 			SH_FSI_LRS_INV	|
+			SH_FSI_CLK_CPG	|
 			SH_FSI_FMT_SPDIF,
-		.set_rate = fsi_b_set_rate,
 	}
 };
 
-- 
1.7.9.5

