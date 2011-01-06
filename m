From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Jan 2011 02:44:09 +0000
Subject: [PATCH 1/2 v2] ARM: mach-shmobile: mackerel: add HDMI video support
Message-Id: <w3phbdmycna.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

no change

 arch/arm/mach-shmobile/board-mackerel.c |  141 +++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3e30a52..eb25972 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -21,6 +21,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -39,6 +40,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/r8a66597.h>
 
+#include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 
 #include <sound/sh_fsi.h>
@@ -290,6 +292,127 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* HDMI */
+static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
+	.clock_source = LCDC_CLK_EXTERNAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = RGB24,
+		.clock_divider = 1,
+		.flags = LCDC_FLAGS_DWPOL,
+	}
+};
+
+static struct resource hdmi_lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC1",
+		.start	= 0xfe944000,
+		.end	= 0xfe947fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x1780),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device hdmi_lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(hdmi_lcdc_resources),
+	.resource	= hdmi_lcdc_resources,
+	.id		= 1,
+	.dev	= {
+		.platform_data	= &hdmi_lcdc_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+static struct sh_mobile_hdmi_info hdmi_info = {
+	.lcd_chan	= &hdmi_lcdc_info.ch[0],
+	.lcd_dev	= &hdmi_lcdc_device.dev,
+};
+
+static struct resource hdmi_resources[] = {
+	[0] = {
+		.name	= "HDMI",
+		.start	= 0xe6be0000,
+		.end	= 0xe6be00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* There's also an HDMI interrupt on INTCS @ 0x18e0 */
+		.start	= evt2irq(0x17e0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device hdmi_device = {
+	.name		= "sh-mobile-hdmi",
+	.num_resources	= ARRAY_SIZE(hdmi_resources),
+	.resource	= hdmi_resources,
+	.id             = -1,
+	.dev	= {
+		.platform_data	= &hdmi_info,
+	},
+};
+
+static int __init hdmi_init_pm_clock(void)
+{
+	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
+	int ret;
+	long rate;
+
+	if (IS_ERR(hdmi_ick)) {
+		ret = PTR_ERR(hdmi_ick);
+		pr_err("Cannot get HDMI ICK: %d\n", ret);
+		goto out;
+	}
+
+	ret = clk_set_parent(&sh7372_pllc2_clk, &sh7372_dv_clki_div2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set PLLC2 parent: %d, %d users\n",
+		       ret, sh7372_pllc2_clk.usecount);
+		goto out;
+	}
+
+	pr_debug("PLLC2 initial frequency %lu\n",
+		 clk_get_rate(&sh7372_pllc2_clk));
+
+	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
+	if (rate < 0) {
+		pr_err("Cannot get suitable rate: %ld\n", rate);
+		ret = rate;
+		goto out;
+	}
+
+	ret = clk_set_rate(&sh7372_pllc2_clk, rate);
+	if (ret < 0) {
+		pr_err("Cannot set rate %ld: %d\n", rate, ret);
+		goto out;
+	}
+
+	ret = clk_enable(&sh7372_pllc2_clk);
+	if (ret < 0) {
+		pr_err("Cannot enable pllc2 clock\n");
+		goto out;
+	}
+
+	pr_debug("PLLC2 set frequency %lu\n", rate);
+
+	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set HDMI parent: %d\n", ret);
+		goto out;
+	}
+
+out:
+	if (!IS_ERR(hdmi_ick))
+		clk_put(hdmi_ick);
+	return ret;
+}
+device_initcall(hdmi_init_pm_clock);
+
 /* USB1 (Host) */
 static void usb1_host_port_power(int port, int power)
 {
@@ -412,6 +535,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
+	&hdmi_lcdc_device,
+	&hdmi_device,
 };
 
 /* Keypad Initialization */
@@ -487,8 +612,11 @@ static void __init mackerel_map_io(void)
 
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
+#define SRCR4		0xe61580bc
 static void __init mackerel_init(void)
 {
+	u32 srcr4;
+
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -567,6 +695,16 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
+	/* HDMI */
+	gpio_request(GPIO_FN_HDMI_HPD, NULL);
+	gpio_request(GPIO_FN_HDMI_CEC, NULL);
+
+	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
+	srcr4 = __raw_readl(SRCR4);
+	__raw_writel(srcr4 | (1 << 13), SRCR4);
+	udelay(50);
+	__raw_writel(srcr4 & ~(1 << 13), SRCR4);
+
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(1, i2c1_devices,
@@ -581,6 +719,9 @@ static void __init mackerel_timer_init(void)
 {
 	sh7372_clock_init();
 	shmobile_timer.init();
+
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 static struct sys_timer mackerel_timer = {
-- 
1.7.1

