From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 03 Jun 2019 19:19:25 +0000
Subject: [PATCH] sh: config: Remove left-over BACKLIGHT_LCD_SUPPORT
Message-Id: <20190603191925.20659-1-krzk@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/sh/configs/hp6xx_defconfig  | 1 -
 arch/sh/configs/sh2007_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 4dcf7f552582..91d43e2bffea 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -40,7 +40,6 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_HIT=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_PEARL_8x8=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index a1cf6447dbb1..cbd6742eb423 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -85,7 +85,6 @@ CONFIG_WATCHDOG=y
 CONFIG_SH_WDT=y
 CONFIG_SSB=y
 CONFIG_FB=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-- 
2.17.1
