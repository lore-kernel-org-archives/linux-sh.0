From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 04:30:37 +0000
Subject: [PATCH v6 1/2] of: add J-Core interrupt controller bindings
Message-Id: <c8aae4597153595cf965efe96422f699639c9d51.147018b6529.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b6529.git.dalias@libc.org>
In-Reply-To: <cover.147018b6529.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Signed-off-by: Rich Felker <dalias@libc.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/jcore,aic.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
new file mode 100644
index 0000000..ee2ad36
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
+  number.
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


