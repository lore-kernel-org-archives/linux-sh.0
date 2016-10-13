From: Rich Felker <dalias@libc.org>
Date: Thu, 13 Oct 2016 21:51:06 +0000
Subject: [PATCH v9 1/2] of: add J-Core timer bindings
Message-Id: <8b107c292ed8cf8eed0fa283071fc8a930098628.1476393790.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1476393790.git.dalias@libc.org>
In-Reply-To: <cover.1476393790.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Rich Felker <dalias@libc.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/timer/jcore,pit.txt        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt

diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
new file mode 100644
index 0000000..af5dd35
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
@@ -0,0 +1,24 @@
+J-Core Programmable Interval Timer and Clocksource
+
+Required properties:
+
+- compatible: Must be "jcore,pit".
+
+- reg: Memory region(s) for timer/clocksource registers. For SMP,
+  there should be one region per cpu, indexed by the sequential,
+  zero-based hardware cpu number.
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
2.10.0


