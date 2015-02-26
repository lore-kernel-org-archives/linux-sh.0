From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 26 Feb 2015 14:08:33 +0000
Subject: [PATCH] ARM: shmobile: r8a7794: alt: Fix ethernet controller PHY IRQ line
Message-Id: <1424959713-21305-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PHY IRQ line is connected to external IRQ8, not IRQ0. Fix DT
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 25bf434433b1..928cfa641475 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -51,7 +51,7 @@
 	phy1: ethernet-phy@1 {
 		reg = <1>;
 		interrupt-parent = <&irqc0>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		micrel,led-mode = <1>;
 	};
 };
-- 
Regards,

Laurent Pinchart

