From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:49:21 +0000
Subject: [PATCH 5/7] ARM: dts: r8a7791-koelsch: Add DVFS parameters into cpu0 node for r8a7791
Message-Id: <5386E681.4070107@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add needed information inside CPU0 for the generic cpufreq-cpu0 driver.

- voltage-tolerance = 1%
  It reflects the tolerance for the CPU voltage defined inside the OPP
  table. Due to the lack of proper OPP definition, use an arbitrary safe
  value.
- clock-latency = 300 us
  Approximate worst-case latency to do a full DVFS transition for every
  OPPs. Due to the lack of HW information, use an arbitrary safe value.
  Note: The term transition-latency will be more accurate to define this
  value since the clock transition latency is not the only parameter that
  will define the overall DVFS transition.
- operating-points = < kHz - uV >
  List of 6 operating points. All of them are using the same voltage
  since DVS is not supported in R-CAR Gen2.
- clocks
  phandle to the CPU clock source. This clock source is used for all the
  2 CortexA15 located inside the same cluster.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8d7ffae..b9b3c74 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -45,6 +45,17 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
+			voltage-tolerance = <1>; /* 1% */
+			clocks = <&cpg_clocks R8A7791_CLK_Z>;
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
 		};
 
 		cpu1: cpu@1 {
-- 
1.7.9.5

