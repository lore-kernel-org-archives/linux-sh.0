From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 10:29:59 +0000
Subject: [PATCH 5/5] serial: sh-sci: Add device tree bindings documentation
Message-Id: <1383042599-25151-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org

Document the device tree bindings for the sci serial port devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/serial/renesas,sci-serial.txt         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
new file mode 100644
index 0000000..5658b4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -0,0 +1,51 @@
+* Renesas SH-Mobile Serial Communication Interface
+
+Required properties:
+
+  - compatible: should be one of the following.
+
+    - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
+    - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
+    - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
+    - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
+    - "renesas,scif-generic" for generic SCIF compatible UART.
+    - "renesas,scifa-generic" for generic SCIFA compatible UART.
+    - "renesas,scifb-generic" for generic SCIFB compatible UART.
+    - "renesas,hscif-generic" for generic HSCIF compatible UART.
+
+    When compatible with the generic version, nodes must also list the
+    SoC-specific version corresponding to the platform.
+
+  - reg: Base address and length of the memory resource used by the UART.
+
+  - interrupt-parent: Reference to the parent interrupt controller.
+  - interrupts: Interrupt number(s). Depending on the SoC SCIx UARTs are tied
+    to one or multiple interrupt lines. When using multiple interrupt lines,
+    specify the interrupt names as described below.
+
+  - clocks: Reference to the SCIx UART interface clock.
+  - clock-names: Should be "sci_ick".
+
+Optional properties:
+
+  - interrupt-names: When using multiple interrupts, report the interrupt
+    names as "eri" (receive error), "rxi" (receive), "txi" (transmit) and
+    "bri" (break). When using a single interrupt this property should not be
+    present.
+
+Note: Each enabled SCIx UART should have an alias correctly numbered in the
+"aliases" node.
+
+Example:
+	aliases {
+		serial0 = &scifa0;
+	};
+
+	scifa0: serial@e6c40000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		reg = <0 0xe6c40000 0 64>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 4>;
+		clocks = <&mstp2_clks 4>;
+		clock-names = "sci_ick";
+	};
-- 
1.8.1.5

