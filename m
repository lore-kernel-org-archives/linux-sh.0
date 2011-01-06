From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Jan 2011 02:44:15 +0000
Subject: [PATCH 2/2 v2] ARM: mach-shmobile: mackerel: Add HDMI sound support
Message-Id: <w3pfwt6ycn4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

o remove FSIA settings from fsi_set_rate, becase it is slave mode,
  and doesn't use external clock now.

o modify clk_put timing on fsi_set_rate 

 arch/arm/mach-shmobile/board-mackerel.c |   95 +++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index eb25972..4c44dae 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -331,6 +331,7 @@ static struct platform_device hdmi_lcdc_device = {
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan	= &hdmi_lcdc_info.ch[0],
 	.lcd_dev	= &hdmi_lcdc_device.dev,
+	.flags		= HDMI_SND_SRC_SPDIF,
 };
 
 static struct resource hdmi_resources[] = {
@@ -492,12 +493,93 @@ static struct platform_device leds_device = {
 
 /* FSI */
 #define IRQ_FSI evt2irq(0x1840)
+static int __fsi_set_round_rate(struct clk *clk, long rate, int enable)
+{
+	int ret;
+
+	if (rate <= 0)
+		return 0;
+
+	if (!enable) {
+		clk_disable(clk);
+		return 0;
+	}
+
+	ret = clk_set_rate(clk, clk_round_rate(clk, rate));
+	if (ret < 0)
+		return ret;
+
+	return clk_enable(clk);
+}
+
+static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
+{
+	struct clk *fsib_clk;
+	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
+	long fsib_rate = 0;
+	long fdiv_rate = 0;
+	int ackmd_bpfmd;
+	int ret;
+
+	/* FSIA is slave mode. nothing to do here */
+	if (is_porta)
+		return 0;
+
+	/* clock start */
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
+	/* fsib */
+	ret = __fsi_set_round_rate(fsib_clk, fsib_rate, enable);
+	if (ret < 0)
+		goto fsi_set_rate_end;
+
+	/* FSI DIV */
+	ret = __fsi_set_round_rate(fdiv_clk, fdiv_rate, enable);
+	if (ret < 0) {
+		/* disable FSI B */
+		if (enable)
+			__fsi_set_round_rate(fsib_clk, fsib_rate, 0);
+		goto fsi_set_rate_end;
+	}
+
+	ret = ackmd_bpfmd;
+
+fsi_set_rate_end:
+	clk_put(fsib_clk);
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
+	.portb_flags =	SH_FSI_BRS_INV	|
+			SH_FSI_BRM_INV	|
+			SH_FSI_LRS_INV	|
+			SH_FSI_OFMT(SPDIF),
+
+	.set_rate = fsi_set_rate,
 };
 
 static struct resource fsi_resources[] = {
@@ -613,9 +695,11 @@ static void __init mackerel_map_io(void)
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
 #define SRCR4		0xe61580bc
+#define USCCR1		0xE6058144
 static void __init mackerel_init(void)
 {
 	u32 srcr4;
+	struct clk *clk;
 
 	sh7372_pinmux_init();
 
@@ -687,6 +771,17 @@ static void __init mackerel_init(void)
 
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

