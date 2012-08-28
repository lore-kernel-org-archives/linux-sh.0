From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Aug 2012 02:00:15 +0000
Subject: [PATCH 7/8] ARM: shmobile: marzen: enable thermal sensor
Message-Id: <87d32bdbdf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Marzen board can measure its thermal by this patch.
	cat /sys/class/thermal/thermal_zoneX/temp

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/marzen_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-marzen.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 00e7216..ef9ee6d 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -72,6 +72,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a74a07c..4a513e9 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -114,9 +114,25 @@ static struct platform_device sdhi0_device = {
 	}
 };
 
+/* Thermal */
+static struct resource thermal_resources[] = {
+	[0] = {
+		.start		= 0xFFC48000,
+		.end		= 0xFFC48038 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device thermal_device = {
+	.name		= "rcar_thermal",
+	.resource	= thermal_resources,
+	.num_resources	= ARRAY_SIZE(thermal_resources),
+};
+
 static struct platform_device *marzen_devices[] __initdata = {
 	&eth_device,
 	&sdhi0_device,
+	&thermal_device,
 };
 
 /* USB */
-- 
1.7.5.4

