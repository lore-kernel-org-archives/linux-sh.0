From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 05:35:09 +0000
Subject: [PATCH v4 1/2] of: add J-Core timer bindings
Message-Id: <e2376554cb80fc0e2e6fc352ef7ca5e50c37ab29.1469594844.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469594843.git.dalias@libc.org>
In-Reply-To: <cover.1469594843.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../devicetree/bindings/timer/jcore,pit.txt        | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt

diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
new file mode 100644
index 0000000..0f42af4
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
@@ -0,0 +1,25 @@
+J-Core Programmable Interval Timer and Clocksource
+
+Required properties:
+
+- compatible: Must be "jcore,pit".
+
+- reg: Memory region(s) for timer/clocksource registers. For SMP,
+  there should be one region per cpu, indexed by the sequential,
+  zero-based hardware cpu number (which is also the logical cpu
+  number).
+
+- interrupts: An interrupt to assign for the timer. The actual pit
+  core is integrated with the aic and allows the timer interrupt
+  assignment to be programmed by software, but this property is
+  required in order to reserve an interrupt number that doesn't
+  conflict with other devices.
+
+
+Example:
+
+timer@200 {
+	compatible = "jcore,pit";
+	reg = < 0x200 0x30 0x500 0x30 >;
+	interrupts = < 0x48 >;
+};
-- 
2.8.1


