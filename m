From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Nov 2010 07:23:17 +0000
Subject: [PATCH 3/6] ARM: mach-shmobile: ap4evb: FSI clock use proper process
Message-Id: <w3p8w0p4w0q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current AP4 FSI didn't use set_rate for ak4642,
and used dummy rate when init.
And FSI driver was modified to always call set_rate.

The user which are using FSI set_rate is only AP4 now.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   96 +++++++++++++++++++++++----------
 sound/soc/sh/fsi.c                    |    8 +---
 2 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 17b8b07..53a281b 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -575,7 +575,7 @@ static int __fsi_set_rate(struct clk *clk, long rate, int enable)
 		return 0;
 
 	if (enable) {
-		ret = clk_set_rate(clk, clk_round_rate(clk, rate));
+		ret = clk_set_rate(clk, rate);
 		if (0 = ret)
 			ret = clk_enable(clk);
 	} else {
@@ -585,7 +585,56 @@ static int __fsi_set_rate(struct clk *clk, long rate, int enable)
 	return ret;
 }
 
-static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
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
+static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
 {
 	struct clk *fsib_clk;
 	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
@@ -594,10 +643,6 @@ static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
 	int ackmd_bpfmd;
 	int ret;
 
-	/* set_rate is not needed if port A */
-	if (is_porta)
-		return 0;
-
 	switch (rate) {
 	case 44100:
 		fsib_rate	= 11283000;
@@ -618,23 +663,35 @@ static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
 	if (IS_ERR(fsib_clk))
 		return -EIO;
 
-	ret = __fsi_set_rate(fsib_clk, fsib_rate, enable);
+	ret = __fsi_set_round_rate(fsib_clk, fsib_rate, enable);
 	clk_put(fsib_clk);
 	if (ret < 0)
 		return ret;
 
 	/* FSI DIV setting */
-	ret = __fsi_set_rate(fdiv_clk, fdiv_rate, enable);
+	ret = __fsi_set_round_rate(fdiv_clk, fdiv_rate, enable);
 	if (ret < 0) {
 		/* disable FSI B */
 		if (enable)
-			__fsi_set_rate(fsib_clk, fsib_rate, 0);
+			__fsi_set_round_rate(fsib_clk, fsib_rate, 0);
 		return ret;
 	}
 
 	return ackmd_bpfmd;
 }
 
+static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
+{
+	int ret;
+
+	if (is_porta)
+		ret = fsi_ak4642_set_rate(dev, rate, enable);
+	else
+		ret = fsi_hdmi_set_rate(dev, rate, enable);
+
+	return ret;
+}
+
 static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
@@ -928,23 +985,11 @@ out:
 
 device_initcall(hdmi_init_pm_clock);
 
-#define FSIACK_DUMMY_RATE 48000
 static int __init fsi_init_pm_clock(void)
 {
 	struct clk *fsia_ick;
 	int ret;
 
-	/*
-	 * FSIACK is connected to AK4642,
-	 * and the rate is depend on playing sound rate.
-	 * So, set dummy rate (= 48k) here
-	 */
-	ret = clk_set_rate(&sh7372_fsiack_clk, FSIACK_DUMMY_RATE);
-	if (ret < 0) {
-		pr_err("Cannot set FSIACK dummy rate: %d\n", ret);
-		return ret;
-	}
-
 	fsia_ick = clk_get(&fsi_device.dev, "icka");
 	if (IS_ERR(fsia_ick)) {
 		ret = PTR_ERR(fsia_ick);
@@ -953,16 +998,9 @@ static int __init fsi_init_pm_clock(void)
 	}
 
 	ret = clk_set_parent(fsia_ick, &sh7372_fsiack_clk);
-	if (ret < 0) {
-		pr_err("Cannot set FSI-A parent: %d\n", ret);
-		goto out;
-	}
-
-	ret = clk_set_rate(fsia_ick, FSIACK_DUMMY_RATE);
 	if (ret < 0)
-		pr_err("Cannot set FSI-A rate: %d\n", ret);
+		pr_err("Cannot set FSI-A parent: %d\n", ret);
 
-out:
 	clk_put(fsia_ick);
 
 	return ret;
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 136414f..4c2404b 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -902,18 +902,12 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
 	struct fsi_master *master = fsi_get_master(fsi);
 	int (*set_rate)(struct device *dev, int is_porta, int rate, int enable);
 	int fsi_ver = master->core->ver;
-	int is_play = fsi_is_play(substream);
 	long rate = params_rate(params);
 	int ret;
 
-	/* if slave mode, set_rate is not needed */
-	if (!fsi_is_master_mode(fsi, is_play))
-		return 0;
-
-	/* it is error if no set_rate */
 	set_rate = master->info->set_rate;
 	if (!set_rate)
-		return -EIO;
+		return 0;
 
 	ret = set_rate(dai->dev, fsi_is_port_a(fsi), rate, 1);
 	if (ret < 0) /* error */
-- 
1.7.0.4

