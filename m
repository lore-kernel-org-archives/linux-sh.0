From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:26 +0000
Subject: [PATCH 5/7] ARM: shmobile: kzm9g_defconfig: Enable missing hardware support
Message-Id: <1408035448-8811-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Based on the DTS

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/kzm9g_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index bd097d455f87..8cb115d74fdf 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -119,6 +119,7 @@ CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_DMADEVICES=y
-- 
1.9.1

