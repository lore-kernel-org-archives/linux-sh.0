From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 04:30:37 +0000
Subject: [PATCH v6 1/2] of: add J-Core timer bindings
Message-Id: <5e1d4f3346f69bdd9d840c8b5a855c1f93ff93f6.147018b3518.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
In-Reply-To: <cover.147018b3518.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Signed-off-by: Rich Felker <dalias@libc.org>
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
2.8.1


