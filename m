From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 21 Aug 2009 01:24:54 +0000
Subject: [PATCH v3 4/4] sh: add FSI driver support for ms7724se
Message-Id: <ubpmanel5.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lethal@linux-sh.org, broonie@opensource.wolfsonmicro.com


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v2 -> v3

o remove un-used dma-sh.h

I used Paul's git for base and merge from
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

 arch/sh/boards/mach-se/7724/setup.c |   89 +++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 9162081..eb144f6 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -22,6 +22,7 @@
 #include <linux/usb/r8a66597.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
+#include <sound/sh_fsi.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
@@ -246,6 +247,65 @@ static struct platform_device ceu1_device = {
 	},
 };
 
+/* FSI */
+/*
+ * FSI-A use external clock which came from ak464x.
+ * So, we should change parent of fsi
+ */
+#define FCLKACR		0xa4150008
+static void fsimck_init(struct clk *clk)
+{
+	u32 status = ctrl_inl(clk->enable_reg);
+
+	/* use external clock */
+	status &= ~0x000000ff;
+	status |= 0x00000080;
+	ctrl_outl(status, clk->enable_reg);
+}
+
+static struct clk_ops fsimck_clk_ops = {
+	.init = fsimck_init,
+};
+
+static struct clk fsimcka_clk = {
+	.name		= "fsimcka_clk",
+	.id		= -1,
+	.ops		= &fsimck_clk_ops,
+	.enable_reg	= (void __iomem *)FCLKACR,
+	.rate		= 0, /* unknown */
+};
+
+struct sh_fsi_platform_info fsi_info = {
+	.porta_flags = SH_FSI_BRS_INV |
+		       SH_FSI_OUT_SLAVE_MODE |
+		       SH_FSI_IN_SLAVE_MODE |
+		       SH_FSI_OFMT(PCM) |
+		       SH_FSI_IFMT(PCM),
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C021d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 108,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+};
+
 /* KEYSC in SoC (Needs SW33-2 set to ON) */
 static struct sh_keysc_info keysc_info = {
 	.mode = SH_KEYSC_MODE_1,
@@ -351,6 +411,7 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&keysc_device,
 	&sh_eth_device,
 	&sh7724_usb0_host_device,
+	&fsi_device,
 };
 
 #define EEPROM_OP   0xBA206000
@@ -418,11 +479,13 @@ static void __init sh_eth_init(void)
 static int __init devices_setup(void)
 {
 	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
+	struct clk *fsia_clk;
 
 	/* Reset Release */
 	ctrl_outw(ctrl_inw(FPGA_OUT) &
 		  ~((1 << 1)  | /* LAN */
 		    (1 << 6)  | /* VIDEO DAC */
+		    (1 << 7)  | /* AK4643 */
 		    (1 << 12) | /* USB0 */
 		    (1 << 14)), /* RMII */
 		  FPGA_OUT);
@@ -558,6 +621,32 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_KEYOUT1,     NULL);
 	gpio_request(GPIO_FN_KEYOUT0,     NULL);
 
+	/* enable FSI */
+	gpio_request(GPIO_FN_FSIMCKB,    NULL);
+	gpio_request(GPIO_FN_FSIMCKA,    NULL);
+	gpio_request(GPIO_FN_FSIOASD,    NULL);
+	gpio_request(GPIO_FN_FSIIABCK,   NULL);
+	gpio_request(GPIO_FN_FSIIALRCK,  NULL);
+	gpio_request(GPIO_FN_FSIOABCK,   NULL);
+	gpio_request(GPIO_FN_FSIOALRCK,  NULL);
+	gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
+	gpio_request(GPIO_FN_FSIIBSD,    NULL);
+	gpio_request(GPIO_FN_FSIOBSD,    NULL);
+	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
+	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
+	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
+	gpio_request(GPIO_FN_FSIIASD,    NULL);
+
+	/* change parent of FSI A */
+	fsia_clk = clk_get(NULL, "fsia_clk");
+	clk_register(&fsimcka_clk);
+	clk_set_parent(fsia_clk, &fsimcka_clk);
+	clk_set_rate(fsia_clk, 11000);
+	clk_set_rate(&fsimcka_clk, 11000);
+	clk_put(fsia_clk);
+
 	/*
 	 * enable SH-Eth
 	 *
-- 
1.6.0.4

