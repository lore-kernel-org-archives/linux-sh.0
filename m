From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:53:40 +0000
Subject: [PATCH/RFC 14/15] ARM: shmobile: r8a7793 dtsi: Add SYSC PM domains
Message-Id: <1433444021-22167-15-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the first Cortex-A15 CPU core and the Cortex-A15 L2 cache/SCU to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index a7e892fe3efa7fd3..498c9fb389f38fbd 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -30,6 +30,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7793_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&pd_ca15_cpu0>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -53,6 +54,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&pd_ca15_scu>;
 
 		arm,data-latency = <4 4 0>;
 		arm,tag-latency = <3 3 3>;
@@ -396,4 +398,40 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,sysc-r8a7793", "renesas,sysc-rcar";
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
 };
-- 
1.9.1

