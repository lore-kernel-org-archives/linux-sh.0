From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 05 Jan 2011 11:25:57 +0000
Subject: [PATCH 3/3] ARM: mach-shmobile: mackerel: Add HDMI sound support
Message-Id: <w3psjx7k2wq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
based on Paul's rmobile-latest branch (not mackerel branch)

 arch/arm/mach-shmobile/board-mackerel.c |   67 ++++++++++++++++++++++++++++++-
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 069377b..4247569 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -331,6 +331,7 @@ static struct platform_device hdmi_lcdc_device = {
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan	= &hdmi_lcdc_info.ch[0],
 	.lcd_dev	= &hdmi_lcdc_device.dev,
+	.flags		= HDMI_SND_SRC_SPDIF,
 };
 
 static struct resource hdmi_resources[] = {
@@ -559,6 +560,52 @@ fsia_ick_out:
 	return 0;
 }
 
+static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
+{
+	struct clk *fsib_clk;
+	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
+	long fsib_rate = 0;
+	long fdiv_rate = 0;
+	int ackmd_bpfmd;
+	int ret;
+
+	switch (rate) {
+	case 44100:
+		fsib_rate	= rate * 256;
+		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
+		break;
+	case 48000:
+		fsib_rate	= 85428000; /* around 48kHz x 256 x 7 */
+		fdiv_rate	= rate * 256;
+		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
+		break;
+	default:
+		pr_err("unsupported rate in FSI2 port B\n");
+		return -EINVAL;
+	}
+
+	/* FSI B setting */
+	fsib_clk = clk_get(dev, "ickb");
+	if (IS_ERR(fsib_clk))
+		return -EIO;
+
+	ret = __fsi_set_round_rate(fsib_clk, fsib_rate, enable);
+	clk_put(fsib_clk);
+	if (ret < 0)
+		return ret;
+
+	/* FSI DIV setting */
+	ret = __fsi_set_round_rate(fdiv_clk, fdiv_rate, enable);
+	if (ret < 0) {
+		/* disable FSI B */
+		if (enable)
+			__fsi_set_round_rate(fsib_clk, fsib_rate, 0);
+		return ret;
+	}
+
+	return ackmd_bpfmd;
+}
+
 static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
 {
 	int ret;
@@ -566,7 +613,7 @@ static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
 	if (is_porta)
 		ret = fsi_ak4642_set_rate(dev, rate, enable);
 	else
-		ret = -EINVAL;
+		ret = fsi_hdmi_set_rate(dev, rate, enable);
 
 	return ret;
 }
@@ -578,6 +625,11 @@ static struct sh_fsi_platform_info fsi_info = {
 			SH_FSI_OFMT(PCM)	|
 			SH_FSI_IFMT(PCM),
 
+	.portb_flags =	SH_FSI_BRS_INV	|
+			SH_FSI_BRM_INV	|
+			SH_FSI_LRS_INV	|
+			SH_FSI_OFMT(SPDIF),
+
 	.set_rate = fsi_set_rate,
 };
 
@@ -694,9 +746,11 @@ static void __init mackerel_map_io(void)
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
 #define SRCR4		0xe61580bc
+#define USCCR1		0xE6058144
 static void __init mackerel_init(void)
 {
 	u32 srcr4;
+	struct clk *clk;
 
 	sh7372_pinmux_init();
 
@@ -768,6 +822,17 @@ static void __init mackerel_init(void)
 
 	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
 
+	/* setup FSI2 port B (HDMI) */
+	gpio_request(GPIO_FN_FSIBCK, NULL);
+	__raw_writew(__raw_readw(USCCR1) & ~(1 << 6), USCCR1); /* use SPDIF */
+
+	/* set SPU2 clock to 119.6 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, clk_round_rate(clk, 119600000));
+		clk_put(clk);
+	}
+
 	/* enable Keypad */
 	gpio_request(GPIO_FN_IRQ9_42,	NULL);
 	set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
-- 
1.7.1

