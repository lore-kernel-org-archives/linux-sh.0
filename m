From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 04 Jul 2018 10:15:45 +0000
Subject: [PATCH 8/9] sh: defconfig: ap325rxa: Enable CEU and sensor driver
Message-Id: <1530699346-3235-9-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, mchehab@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Enable the new renesas-ceu driver and drivers for the OV7720
image sensor installed on AP325RXA development board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/configs/ap325rxa_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 47c7344..ddf5e29 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -55,6 +55,11 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_CEU=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_OV772X=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.7.4

