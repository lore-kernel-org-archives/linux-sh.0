From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 07:59:59 +0000
Subject: [PATCH v2 2/3] irqchip: renesas-irqc: Add DT binding documentation
Message-Id: <1409212800-4957-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The renesas-irqc driver supports DT, but the DT binding documentation was
missing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Acked-by
  - Remove last blank line
---
 .../bindings/interrupt-controller/renesas,irqc.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
new file mode 100644
index 000000000000..48e8291e5bcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -0,0 +1,29 @@
+DT bindings for the R-Mobile/R-Car interrupt controller
+
+Required properties:
+
+- compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
+  Examples with soctypes are:
+    - "renesas,irqc-r8a73a4" (R-Mobile AP6)
+    - "renesas,irqc-r8a7790" (R-Car H2)
+    - "renesas,irqc-r8a7791" (R-Car M2)
+- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+	irqc0: interrupt-controller@e61c0000 {
+		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0 0xe61c0000 0 0x200>;
+		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.9.1

