From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Dec 2014 09:39:41 +0000
Subject: [PATCH 02/02] ARM: shmobile: r8a7779: Add TWD device to DTS
Message-Id: <20141216093941.14252.13361.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when r8a7779 CCF is in place we can hook up
the ARM Cortex-A9 TWD timer via DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20141216v2-v3.18
 No special dependencies

 arch/arm/boot/dts/r8a7779.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-16 18:19:23.000000000 +0900
@@ -12,6 +12,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/r8a7779-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -62,6 +63,14 @@
 		      <0xf0000100 0x100>;
 	};
 
+	timer@f0000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xf0000600 0x20>;
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
+	};
+
 	gpio0: gpio@ffc40000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
