From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 05 Jan 2011 11:25:26 +0000
Subject: [PATCH 1/3] ARM: mach-shmobile: mackerel: Add fsi_set_rate
Message-Id: <w3pvd23k2xl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
based on Paul's rmobile-latest branch (not mackerel branch)

 arch/arm/mach-shmobile/board-mackerel.c |   81 +++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3e30a52..83e83e8 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -369,12 +369,93 @@ static struct platform_device leds_device = {
 
 /* FSI */
 #define IRQ_FSI evt2irq(0x1840)
+static int __fsi_set_rate(struct clk *clk, long rate, int enable)
+{
+	int ret = 0;
+
+	if (rate <= 0)
+		return ret;
+
+	if (enable) {
+		ret = clk_set_rate(clk, rate);
+		if (0 = ret)
+			ret = clk_enable(clk);
+	} else {
+		clk_disable(clk);
+	}
+
+	return ret;
+}
+
+static int __fsi_set_round_rate(struct clk *clk, long rate, int enable)
+{
+	return __fsi_set_rate(clk, clk_round_rate(clk, rate), enable);
+}
+
+static int fsi_ak4642_set_rate(struct device *dev, int rate, int enable)
+{
+	struct clk *fsia_ick;
+	struct clk *fsiack;
+	int ret = -EIO;
+
+	fsia_ick = clk_get(dev, "icka");
+	if (IS_ERR(fsia_ick))
+		return PTR_ERR(fsia_ick);
+
+	/*
+	 * FSIACK is connected to AK4642,
+	 * and use external clock pin from it.
+	 * it is parent of fsia_ick now.
+	 */
+	fsiack = clk_get_parent(fsia_ick);
+	if (!fsiack)
+		goto fsia_ick_out;
+
+	/*
+	 * we get 1/1 divided clock by setting same rate to fsiack and fsia_ick
+	 *
+	 ** FIXME **
+	 * Because the freq_table of external clk (fsiack) are all 0,
+	 * the return value of clk_round_rate became 0.
+	 * So, it use __fsi_set_rate here.
+	 */
+	ret = __fsi_set_rate(fsiack, rate, enable);
+	if (ret < 0)
+		goto fsiack_out;
+
+	ret = __fsi_set_round_rate(fsia_ick, rate, enable);
+	if ((ret < 0) && enable)
+		__fsi_set_round_rate(fsiack, rate, 0); /* disable FSI ACK */
+
+fsiack_out:
+	clk_put(fsiack);
+
+fsia_ick_out:
+	clk_put(fsia_ick);
+
+	return 0;
+}
+
+static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
+{
+	int ret;
+
+	if (is_porta)
+		ret = fsi_ak4642_set_rate(dev, rate, enable);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags =	SH_FSI_BRS_INV		|
 			SH_FSI_OUT_SLAVE_MODE	|
 			SH_FSI_IN_SLAVE_MODE	|
 			SH_FSI_OFMT(PCM)	|
 			SH_FSI_IFMT(PCM),
+
+	.set_rate = fsi_set_rate,
 };
 
 static struct resource fsi_resources[] = {
-- 
1.7.1

