From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 18 Dec 2014 02:26:07 +0000
Subject: [PATCH 1/4] ARM: shmobile: sh73a0: Set control-parent for all irqpin nodes
Message-Id: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh73a0 INTC can't mask interrupts properly most likely due to a
hardware bug. Set the control-parent property to delegate masking to the
parent interrupt controller.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 5dae3d335a5d..2d2f0766a099 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -154,6 +154,7 @@
 		power-domains = <&pd_a4s>;
 		stop-latency = <250000>;
 		start-latency = <250000>;
+		control-parent;
 	};
 
 	irqpin1: irqpin@e6900004 {
@@ -201,6 +202,7 @@
 		power-domains = <&pd_a4s>;
 		stop-latency = <250000>;
 		start-latency = <250000>;
+		control-parent;
 	};
 
 	irqpin3: irqpin@e690000c {
@@ -224,6 +226,7 @@
 		power-domains = <&pd_a4s>;
 		stop-latency = <250000>;
 		start-latency = <250000>;
+		control-parent;
 	};
 
 	i2c0: i2c@e6820000 {
-- 
2.0.4

