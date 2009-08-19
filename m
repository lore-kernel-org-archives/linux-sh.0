From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 19 Aug 2009 11:25:28 +0000
Subject: [PATCH 3/3] Add FSI-AK464x sound support for ms7724se
Message-Id: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>, broonie@opensource.wolfsonmicro.com


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/Kconfig                   |    9 +++
 arch/sh/boards/mach-se/7724/Makefile     |    3 +-
 arch/sh/boards/mach-se/7724/fsi-ak464x.c |   90 ++++++++++++++++++++++++++++++
 arch/sh/boards/mach-se/7724/setup.c      |   90 ++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/boards/mach-se/7724/fsi-ak464x.c

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index db04c85..44f4c8b 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -55,6 +55,15 @@ config SH_7724_SOLUTION_ENGINE
 	  Select 7724 SolutionEngine if configuring for a Hitachi SH7724
 	  evaluation board.
 
+config SND_SH4_FSI_AK464X
+	bool "FSI-AK464X sound support"
+	depends on SND_SOC_SH4_FSI
+	depends on SH_7724_SOLUTION_ENGINE
+	select SND_SOC_AK464X
+	help
+	  This option enables generic sound support for the
+	  FSI - AK464x unit of the SH4.
+
 config SH_7751_SOLUTION_ENGINE
 	bool "SolutionEngine7751"
 	select SOLUTION_ENGINE
diff --git a/arch/sh/boards/mach-se/7724/Makefile b/arch/sh/boards/mach-se/7724/Makefile
index 349cbd6..e0f5366 100644
--- a/arch/sh/boards/mach-se/7724/Makefile
+++ b/arch/sh/boards/mach-se/7724/Makefile
@@ -7,4 +7,5 @@
 #
 #
 
-obj-y	 := setup.o irq.o
\ No newline at end of file
+obj-y	 := setup.o irq.o
+obj-$(CONFIG_SND_SH4_FSI_AK464X) += fsi-ak464x.o
diff --git a/arch/sh/boards/mach-se/7724/fsi-ak464x.c b/arch/sh/boards/mach-se/7724/fsi-ak464x.c
new file mode 100644
index 0000000..bab118e
--- /dev/null
+++ b/arch/sh/boards/mach-se/7724/fsi-ak464x.c
@@ -0,0 +1,90 @@
+/*
+ * FSI-AK464x sound support for ms7724se
+ *
+ * Copyright (C) 2009 Renesas Solutions Corp.
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/io.h>
+
+#include <sound/fsi.h>
+#include <../sound/soc/codecs/ak464x.h>
+
+static int machine_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link fsi_dai_link = {
+	.name		= "AK464x",
+	.stream_name	= "AK464x",
+	.cpu_dai	= &fsi_soc_dai[0],	/* fsi */
+	.codec_dai	= &ak464x_dai,
+	.init		= machine_init,
+	.ops		= NULL,
+};
+
+static struct snd_soc_card fsi_soc_card  = {
+	.name		= "SH4 I2S (FSI)",
+	.platform	= &fsi_soc_platform,
+	.dai_link	= &fsi_dai_link,
+	.num_links	= 1,
+};
+
+struct ak464x_setup_data ak464x_setup = {
+	.i2c_bus	= 0,
+	.i2c_address	= 0x12, /* 0x13 */
+};
+
+static struct snd_soc_device fsi_snd_devdata = {
+	.card		= &fsi_soc_card,
+	.codec_dev	= &soc_codec_dev_ak464x,
+	.codec_data	= &ak464x_setup,
+};
+
+static struct platform_device *fsi_snd_device;
+
+static int __init fsi_ak464x_init(void)
+{
+	int ret;
+
+	ret = -ENOMEM;
+	fsi_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!fsi_snd_device)
+		goto out;
+
+	platform_set_drvdata(fsi_snd_device,
+			     &fsi_snd_devdata);
+	fsi_snd_devdata.dev = &fsi_snd_device->dev;
+	ret = platform_device_add(fsi_snd_device);
+
+	if (ret)
+		platform_device_put(fsi_snd_device);
+
+out:
+	return ret;
+}
+
+static void __exit fsi_ak464x_exit(void)
+{
+	platform_device_unregister(fsi_snd_device);
+}
+
+module_init(fsi_ak464x_init);
+module_exit(fsi_ak464x_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic SH4 FSI-AK464x sound card");
+MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 9162081..0099a79 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -22,11 +22,13 @@
 #include <linux/usb/r8a66597.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
+#include <sound/fsi.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
 #include <asm/sh_keysc.h>
+#include <asm/dma-sh.h>
 #include <cpu/sh7724.h>
 #include <mach-se/mach/se7724.h>
 
@@ -246,6 +248,65 @@ static struct platform_device ceu1_device = {
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
@@ -351,6 +412,7 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&keysc_device,
 	&sh_eth_device,
 	&sh7724_usb0_host_device,
+	&fsi_device,
 };
 
 #define EEPROM_OP   0xBA206000
@@ -418,11 +480,13 @@ static void __init sh_eth_init(void)
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
@@ -558,6 +622,32 @@ static int __init devices_setup(void)
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

