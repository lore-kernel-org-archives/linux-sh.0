From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 13 Jun 2013 23:45:59 +0000
Subject: [PATCH v6 14/18] ARM: shmobile: armadillo-reference: Add st1232 pin mappings
Message-Id: <1371167163-10507-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add pin mappings for the st1232 device to the device tree and reference
them as the default state for the device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 4a7ae32..a6c6606 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -41,6 +41,8 @@
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
 		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
+		pinctrl-0 = <&st1232_pins>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -52,4 +54,9 @@
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
 	};
+
+	st1232_pins: st1232 {
+		renesas,groups = "intc_irq10";
+		renesas,function = "intc";
+	};
 };
-- 
1.8.1.5

