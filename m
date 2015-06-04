From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:53:39 +0000
Subject: [PATCH/RFC 13/15] ARM: shmobile: r8a7791 dtsi: Add SYSC PM domains
Message-Id: <1433444021-22167-14-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A15 CPU cores and the Cortex-A15 L2 cache/SCU to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4e4011a2978bcfce..3554043ee2af3b26 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -51,6 +51,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&pd_ca15_cpu0>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -76,6 +77,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			power-domains = <&pd_ca15_cpu1>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -91,6 +93,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&pd_ca15_scu>;
 
 		arm,data-latency = <4 4 0>;
 		arm,tag-latency = <3 3 3>;
@@ -1406,6 +1409,43 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,sysc-r8a7791", "renesas,sysc-rcar";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_ca15_scu: scu@12 {
+				reg = <12 0x180>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca15_cpu0: cpu@0 {
+					reg = <0 0x40>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu1: cpu@1 {
+					reg = <1 0x41>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh@16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx@20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1

