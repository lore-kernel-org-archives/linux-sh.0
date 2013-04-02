From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Apr 2013 04:31:32 +0000
Subject: [PATCH 1/3] ARM: shmobile: marzen: defconfig: add GPIO RCAR driver support
Message-Id: <1364877094-1508-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This enables the driver added in "gpio: Renesas R-Car GPIO driver V3"

Cc: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 8e7329b..9f65975 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -79,6 +79,7 @@ CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.7.10.4

