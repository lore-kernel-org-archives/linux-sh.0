From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:20:59 +0000
Subject: [PATCH 02/32] ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
Message-Id: <48bdf06dd975fb01e54e0b0406de720ebeeb55c7.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh73a0 INTC can't mask interrupts properly most likely due to a
hardware bug. Set the control-parent property to delegate masking to the
parent interrupt controller.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 2dfd5b4..0767087 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -94,6 +94,7 @@
 			      0 6 IRQ_TYPE_LEVEL_HIGH
 			      0 7 IRQ_TYPE_LEVEL_HIGH
 			      0 8 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	irqpin1: irqpin@e6900004 {
@@ -133,6 +134,7 @@
 			      0 22 IRQ_TYPE_LEVEL_HIGH
 			      0 23 IRQ_TYPE_LEVEL_HIGH
 			      0 24 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	irqpin3: irqpin@e690000c {
@@ -152,6 +154,7 @@
 			      0 30 IRQ_TYPE_LEVEL_HIGH
 			      0 31 IRQ_TYPE_LEVEL_HIGH
 			      0 32 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	i2c0: i2c@e6820000 {
-- 
2.1.4

