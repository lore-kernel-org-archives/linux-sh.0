From: Rich Felker <dalias@libc.org>
Date: Tue, 17 May 2016 23:18:29 +0000
Subject: [PATCH v5 1/2] of: add J-Core interrupt controller bindings
Message-Id: <1ca2ecb9445cf3a3d252ab89122a9b5c6dbb5491.1469688756.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688756.git.dalias@libc.org>
In-Reply-To: <cover.1469688756.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Signed-off-by: Rich Felker <dalias@libc.org>
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


