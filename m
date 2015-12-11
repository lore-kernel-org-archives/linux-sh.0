From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 10:45:25 +0000
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
Message-Id: <1449830727-325-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Renesas R-Car (Gen1) USB PHY driver (which is being removed) does
not support DT, and is thus useless in a generic ARM multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2735bc73b2854882..e0fb5f34c0aca450 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -545,7 +545,6 @@ CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
 CONFIG_USB_MXS_PHY=y
-CONFIG_USB_RCAR_PHY=m
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_ETH=m
-- 
1.9.1

