From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 05:35:09 +0000
Subject: [PATCH v4 1/2] of: add J-Core interrupt controller bindings
Message-Id: <9039efc9336670b3399b9104f1ab5e1a2d8d9025.1469595861.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
In-Reply-To: <cover.1469595860.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../bindings/interrupt-controller/jcore,aic.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
new file mode 100644
index 0000000..b7a56ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
@@ -0,0 +1,26 @@
+J-Core Advanced Interrupt Controller
+
+Required properties:
+
+- compatible: Should be "jcore,aic1" for the (obsolete) first-generation aic
+  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
+  the "aic2" core with 64 interrupts.
+
+- reg: Memory region(s) for configuration. For SMP, there should be one
+  region per cpu, indexed by the sequential, zero-based hardware cpu
+  number (which is also the logical cpu number).
+
+- interrupt-controller: Identifies the node as an interrupt controller
+
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+
+
+Example:
+
+aic: interrupt-controller@200 {
+	compatible = "jcore,aic2";
+	reg = < 0x200 0x30 0x500 0x30 >;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+};
-- 
2.8.1


