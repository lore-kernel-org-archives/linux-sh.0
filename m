From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 09:53:55 +0000
Subject: [PATCH v3 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <20140212095355.4832.61506.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0, SDHI1 and SDHI2 to the r8a7791 DTSI.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

Changes since V2:
 - Move back to V1 =)

Changes since V1:
 - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver

 arch/arm/boot/dts/r8a7791.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2014-02-10 16:35:25.000000000 +0900
@@ -186,6 +186,33 @@
 		#gpio-range-cells = <3>;
 	};
 
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee100000 0 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		status = "disabled";
+	};
+
+	sdhi1: sd@ee140000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		status = "disabled";
+	};
+
+	sdhi2: sd@ee160000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee160000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		status = "disabled";
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
