From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:34:04 +0000
Subject: [PATCH 11/11] ARM: shmobile: bockw: add USB Function support
Message-Id: <877ggxfqbr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
was selected on this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c   |   80 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/clock-r8a7778.c |    1 +
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 8978f61..a005fba 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -32,6 +32,7 @@
 #include <linux/smsc911x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
@@ -62,6 +63,16 @@
  * SW19	(MMC)	1 pin
  */
 
+/*
+ * USB
+ *
+ * USB1 (CN29) can be Host/Function
+ *
+ *		Host	Func
+ * SW98		0	2
+ * SW99		0	3
+ */
+
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x"),
@@ -160,13 +171,70 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_NEEDS_POLL,
 };
 
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
+/*
+ * When USB1 is Func
+ */
+static int usbhsf_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+#define SUSPMODE	0x102
+static int usbhsf_power_ctrl(struct platform_device *pdev,
+			     void __iomem *base, int enable)
+{
+	enable = !!enable;
+
+	r8a7778_usb_phy_power(enable);
+
+	iowrite16(enable << 14, base + SUSPMODE);
+
+	return 0;
+}
+
+static struct resource usbhsf_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe60000, 0x110),
+	DEFINE_RES_IRQ(gic_iid(0x4f)),
+};
+
+static struct renesas_usbhs_platform_info usbhs_info = {
+	.platform_callback = {
+		.get_id		= usbhsf_get_id,
+		.power_ctrl	= usbhsf_power_ctrl,
+	},
+	.driver_param = {
+		.buswait_bwait	= 4,
+	},
+};
+
+#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
+#define USB1_DEVICE	"renesas_usbhs"
+#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE			\
+	platform_device_register_resndata(		\
+		&platform_bus, "renesas_usbhs", -1,	\
+		usbhsf_resources,			\
+		ARRAY_SIZE(usbhsf_resources),		\
+		&usbhs_info, sizeof(struct renesas_usbhs_platform_info))
+
+#else
+/*
+ * When USB1 is Host
+ */
+#define USB_PHY_SETTING { }
+#define USB1_DEVICE	"ehci-platform"
+#define ADD_USB_FUNC_DEVICE_IF_POSSIBLE
+
+#endif
+
 /* USB PHY */
 static struct resource usb_phy_resources[] __initdata = {
 	DEFINE_RES_MEM(0xffe70800, 0x100),
 	DEFINE_RES_MEM(0xffe76000, 0x100),
 };
 
-static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+static struct rcar_phy_platform_data usb_phy_platform_data __initdata +	USB_PHY_SETTING;
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
@@ -188,9 +256,10 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
 				  "sdhi0", "sdhi0"),
+	/* USB */
 	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
 				  "usb0", "usb0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
+	PIN_MAP_MUX_GROUP_DEFAULT(USB1_DEVICE, "pfc-r8a7778",
 				  "usb1", "usb1"),
 };
 
@@ -276,6 +345,11 @@ static void __init bockw_init(void)
 	}
 }
 
+static void __init bockw_init_late(void)
+{
+	ADD_USB_FUNC_DEVICE_IF_POSSIBLE;
+}
+
 static const char *bockw_boards_compat_dt[] __initdata = {
 	"renesas,bockw",
 	NULL,
@@ -287,5 +361,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_machine	= bockw_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
-	.init_late      = r8a7778_init_late,
+	.init_late      = bockw_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 53798e5..0d34282 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -148,6 +148,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
+	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP100]), /* USB FUNC */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
 	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
 	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
-- 
1.7.9.5

