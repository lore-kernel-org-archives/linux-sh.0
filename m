From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 01 Oct 2013 18:30:47 +0000
Subject: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds USBHS phy control callbacks to the Lager board and
registers USBHS device if the driver is enabled.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 142 +++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a8d3ce6..e408fc7 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -34,6 +35,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
@@ -165,6 +167,142 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
+/* USBHS */
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
+static const struct resource usbhs_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6590000, 0x200),
+	DEFINE_RES_IRQ(gic_spi(107)),
+};
+
+/* USBHS registers */
+#define USBHS_LPSTS_REG			0x102
+#define USBHS_LPSTS_SUSPM		(1 << 14)
+
+#define USBHS_UGCTRL_REG		0x180
+#define USBHS_UGCTRL_CONNECT		(1 << 2)
+#define USBHS_UGCTRL_PLLRESET		(1 << 0)
+
+#define USBHS_UGCTRL2_REG		0x184
+#define USBHS_UGCTRL2_USB0_PCI		(1 << 4)
+#define USBHS_UGCTRL2_USB0_HS		(3 << 4)
+#define USBHS_UGCTRL2_USB2_PCI		(0 << 31)
+#define USBHS_UGCTRL2_USB2_SS		(1 << 31)
+
+#define USBHS_UGSTS_REG			0x190
+#define USBHS_UGSTS_LOCK		(3 << 0)
+
+struct usbhs_private {
+	struct renesas_usbhs_platform_info info;
+	struct platform_device *pdev;
+	struct clk *clk;
+};
+
+#define usbhs_get_priv(pdev) \
+	container_of(renesas_usbhs_get_info(pdev), struct usbhs_private, info)
+
+static int usbhs_power_on(void __iomem *base)
+{
+	u32 val;
+
+	val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_PLLRESET;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+
+	val = ioread16(base + USBHS_LPSTS_REG) | USBHS_LPSTS_SUSPM;
+	iowrite16(val, base + USBHS_LPSTS_REG);
+
+	/*
+	 * The manual suggests to check PLL lock status in the UGSTS
+	 * register before enabling connect, however, it is always 0.
+	 */
+	val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_CONNECT;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+	return 0;
+}
+
+static int usbhs_power_off(void __iomem *base)
+{
+	u32 val;
+
+	val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_CONNECT;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+
+	val = ioread16(base + USBHS_LPSTS_REG) & ~USBHS_LPSTS_SUSPM;
+	iowrite16(val, base + USBHS_LPSTS_REG);
+
+	val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_PLLRESET;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+	return 0;
+}
+
+static int usbhs_power_ctrl(struct platform_device *pdev,
+				void __iomem *base, int enable)
+{
+	if (enable)
+		return usbhs_power_on(base);
+
+	return usbhs_power_off(base);
+}
+
+static int usbhs_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static int usbhs_hardware_init(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+	struct clk *clk;
+
+	clk = clk_get(NULL, "hsusb");
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	/* Enable clocks */
+	clk_enable(clk);
+	priv->clk = clk;
+	priv->pdev = pdev;
+	return 0;
+}
+
+static int usbhs_hardware_exit(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	if (!priv->clk)
+		return 0;
+
+	/* Disable clocks */
+	clk_disable(priv->clk);
+	clk_put(priv->clk);
+	priv->clk = NULL;
+	return 0;
+}
+
+static struct usbhs_private usbhs_priv __initdata = {
+	.info = {
+		.platform_callback = {
+			.power_ctrl	= usbhs_power_ctrl,
+			.get_id		= usbhs_get_id,
+			.hardware_init	= usbhs_hardware_init,
+			.hardware_exit	= usbhs_hardware_exit,
+		},
+		.driver_param = {
+			.buswait_bwait	= 4,
+		},
+	},
+};
+
+#define lager_register_usbhs()						\
+	platform_device_register_resndata(&platform_bus,		\
+					  "renesas_usbhs", -1,		\
+					  usbhs_resources,		\
+					  ARRAY_SIZE(usbhs_resources),	\
+					  &usbhs_priv.info,		\
+					  sizeof(usbhs_priv.info))
+#else	/* CONFIG_USB_RENESAS_USBHS_UDC */
+#define lager_register_usbhs()
+#endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -193,6 +331,9 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "eth_rmii", "eth"),
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
 				  "intc_irq0", "intc"),
+	/* USB0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
+				  "usb0", "usb0"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -222,6 +363,7 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
+	lager_register_usbhs();
 }
 
 /*
-- 
1.8.3.1

