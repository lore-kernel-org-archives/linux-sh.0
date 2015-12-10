From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 10 Dec 2015 15:16:00 +0000
Subject: [PATCH 1/3] ARM: shmobile: defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
Message-Id: <1449760562-26795-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449760562-26795-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Renesas R-Car (Gen1) USB PHY driver (which is being removed) does
not support DT, and is thus useless in a Renesas ARM multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 70d718e088a65fed..9a30c2c464c946ca 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -162,7 +162,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
-CONFIG_USB_RCAR_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
 CONFIG_USB_ETH=y
-- 
1.9.1

