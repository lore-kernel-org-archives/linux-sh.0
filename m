From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 08 Aug 2013 12:03:34 +0000
Subject: [PATCH v3 8/8] ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig
Message-Id: <1375963414-31096-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A R-Car DU DRM device is registered for the Lager board, select the
corresponding driver in its defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/configs/lager_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index e777ef2..35bff5e 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -89,6 +89,8 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
1.8.1.5

