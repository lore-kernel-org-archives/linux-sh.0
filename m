From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Nov 2013 01:18:20 +0000
Subject: [RFC 05/17] ARM: shmobile: r8a7779: Reference clocks
Message-Id: <1385342312-1967-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reference clocks using a "clocks" property in all nodes corresponding to
devices that require a clock.

Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d524b3f..623dd39 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -160,6 +160,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -170,6 +171,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -180,6 +182,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -190,6 +193,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
 		status = "disabled";
 	};
 
@@ -215,6 +219,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -225,6 +230,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -235,6 +241,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
@@ -245,6 +252,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
 		cap-sd-highspeed;
 		cap-sdio-irq;
 		status = "disabled";
-- 
1.8.4

