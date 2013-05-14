From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 14 May 2013 21:35:11 +0000
Subject: [PATCH 1/2] ARM: shmobile: marzen-reference: Reference the correct IRQ for ethernet
Message-Id: <1368567312-11640-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SMSC ethernet controller uses an external IRQ line that goes through
the irqpin controller. Set the interrupt parent to irqpin0 and fix the
interrupt number.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 72be4c8..10cfc7f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -38,8 +38,8 @@
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
 		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
+		interrupt-parent = <&irqpin0>;
+		interrupts = <1 0x4>;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
-- 
1.8.1.5

