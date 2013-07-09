From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 05:53:41 +0000
Subject: [PATCH 4/4] ARM: shmobile: bockw: add USB Function support
Message-Id: <87a9lwth26.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
was selected

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   49 +++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index a57be8a..1a4918f 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -58,6 +58,16 @@
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
@@ -140,7 +150,39 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_NEEDS_POLL,
 };
 
-static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+/* USB */
+#if	defined(CONFIG_USB_RENESAS_USBHS_UDC) || \
+	defined(CONFIG_USB_RENESAS_USBHS_UDC_MODULE)
+
+	/* USB1 is Func */
+	static struct renesas_usbhs_platform_info usbhs_info = {
+		.platform_callback = {
+			/* .get_id	will be set in register function */
+			/* .power_ctrl	will be set in register function */
+		},
+		.driver_param = {
+			.buswait_bwait	= 4,
+		},
+	};
+
+	#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
+	#define PIN_MAP_MUX_GROUP_USB1 \
+		PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7778", \
+					  "usb1_ovc", "usb1")
+	#define R8A7778_ADD_USB_FUNC_DEVICE_IF_POSSIBLE \
+		r8a7778_add_usb_func_device(&usbhs_info)
+#else
+	/* USB1 is Host */
+	#define USB_PHY_SETTING { }
+	#define PIN_MAP_MUX_GROUP_USB1 \
+		PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778", \
+					  "usb1", "usb1")
+	#define R8A7778_ADD_USB_FUNC_DEVICE_IF_POSSIBLE
+#endif
+
+static struct rcar_phy_platform_data usb_phy_platform_data __initdata +	USB_PHY_SETTING;
+
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* Ether */
@@ -162,10 +204,10 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
 				  "sdhi0", "sdhi0"),
+	/* USB */
 	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
 				  "usb0", "usb0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
-				  "usb1", "usb1"),
+	PIN_MAP_MUX_GROUP_USB1,
 };
 
 #define FPGA	0x18200000
@@ -235,6 +277,7 @@ static void __init bockw_init(void)
 static void __init bockw_init_late(void)
 {
 	r8a7778_add_usb_host_device();
+	R8A7778_ADD_USB_FUNC_DEVICE_IF_POSSIBLE;
 }
 
 static const char *bockw_boards_compat_dt[] __initdata = {
-- 
1.7.9.5

