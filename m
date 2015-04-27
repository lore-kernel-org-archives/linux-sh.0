From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 14:45:37 +0000
Subject: [PATCH v2] irqchip: renesas-intc-irqpin: Improve binding documentation
Message-Id: <1430145937-29267-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304051128090.997@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304051128090.997@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add missing documentation for required properties:
  - interrupt-controller,
  - parent interrupts (one entry per provided interrupt).

Add missing documentation for optional properties:
  - functional clock (managed since commit 705bc96c2c15313c ("irqchip:
    renesas-intc-irqpin: Add minimal runtime PM support")),
  - power-domains.

Add an example, taken from r8a7740.dtsi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is v2 of "irqchip: renesas-intc-irqpin: Add optional functional
clock to bindings":
  - Document all missing properties, not just the functional clock,
  - Use a generic name for the device node in the example.
---
 .../interrupt-controller/renesas,intc-irqpin.txt   | 39 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
index 4f7946ae8adcdc04..772c550d3b4bcfe2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -13,9 +13,12 @@ Required properties:
 - reg: Base address and length of each register bank used by the external
   IRQ pins driven by the interrupt controller hardware module. The base
   addresses, length and number of required register banks varies with soctype.
-
+- interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
-  interrupts.txt in this directory
+  interrupts.txt in this directory.
+- interrupts: Must contain a list of interrupt specifiers. For each interrupt
+  provided by this irqpin controller instance, there must be one entry,
+  referring to the corresponding parent interrupt.
 
 Optional properties:
 
@@ -25,3 +28,35 @@ Optional properties:
   if different from the default 4 bits
 - control-parent: disable and enable interrupts on the parent interrupt
   controller, needed for some broken implementations
+- clocks: Must contain a reference to the functional clock.  This property is
+  mandatory if the hardware implements a controllable functional clock for
+  the irqpin controller instance.
+- power-domains: Must contain a reference to the power domain. This property is
+  mandatory if the irqpin controller instance is part of a controllable power
+  domain.
+
+
+Example
+-------
+
+	irqpin1: interrupt-controller@e6900004 {
+		compatible = "renesas,intc-irqpin-r8a7740",
+			     "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900004 4>,
+			<0xe6900014 4>,
+			<0xe6900024 1>,
+			<0xe6900044 1>,
+			<0xe6900064 1>;
+		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH
+			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
+		power-domains = <&pd_a4s>;
+	};
-- 
1.9.1

