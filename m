From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:23 +0000
Subject: [PATCH 2/7] ARM: shmobile: ape6evm_defconfig: Enable missing hardware support
Message-Id: <1408035448-8811-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Based on the DTS

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/ape6evm_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index bb396c0e5fda..b54b28fc5a70 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -12,7 +12,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
-# CONFIG_BLOCK is not set
 CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_MACH_APE6EVM=y
@@ -64,6 +63,8 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_SH_PFC=y
 CONFIG_GPIOLIB=y
 # CONFIG_HWMON is not set
@@ -72,11 +73,17 @@ CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX8973=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SDHI=y
+CONFIG_MMC_SH_MMCIF=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_DMADEVICES=y
+CONFIG_SH_DMAE=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
-- 
1.9.1

