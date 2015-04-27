From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:30 +0000
Subject: [PATCH 06/10] ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
Message-Id: <1430139334-15272-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 45b539ce4d352035..0bdb1da60487b431 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -90,7 +90,7 @@
 		status = "disabled";
 	};
 
-	irqpin0: irqpin@e6900000 {
+	irqpin0: interrupt-controller@e6900000 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -112,7 +112,7 @@
 		control-parent;
 	};
 
-	irqpin1: irqpin@e6900004 {
+	irqpin1: interrupt-controller@e6900004 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -134,7 +134,7 @@
 		control-parent;
 	};
 
-	irqpin2: irqpin@e6900008 {
+	irqpin2: interrupt-controller@e6900008 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -156,7 +156,7 @@
 		control-parent;
 	};
 
-	irqpin3: irqpin@e690000c {
+	irqpin3: interrupt-controller@e690000c {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
1.9.1

