From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:04 +0000
Subject: [PATCH v2 03/12] of: add J-Core interrupt controller bindings
Message-Id: <2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
In-Reply-To: <cover.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../bindings/interrupt-controller/jcore,aic.txt    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
new file mode 100644
index 0000000..dc9fde8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
@@ -0,0 +1,28 @@
+J-Core Advanced Interrupt Controller
+
+Required properties:
+
+- compatible : Should be "jcore,aic1" for the (obsolete) first-generation aic
+  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
+  the "aic2" core with 64 interrupts.
+
+- interrupt-controller : Identifies the node as an interrupt controller
+
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+
+Additional properties required for aic1:
+
+- reg : Memory region for configuration.
+
+- cpu-offset : For SMP, the offset to the per-cpu memory region for
+  configuration, to be scaled by the cpu number.
+
+
+Example:
+
+aic: interrupt-controller {
+	compatible = "jcore,aic2";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+};
-- 
2.8.1


