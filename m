From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:48:36 +0000
Subject: [PATCH 1/7] ARM: dts: r8a7790-lager: Add DVFS parameters into cpu0 node for r8a7790
Message-Id: <5386E654.5090108@bp.renesas.com>
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
  since the valid Vmin voltage is not documented in the HW spec.
- clocks
  phandle to the CPU clock source. This clock source is used for all the
  4 CortexA15 located inside the same cluster.

Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |    4 ++++
 arch/arm/boot/dts/r8a7790.dtsi      |   11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9becef7..ab73ed0 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -317,3 +317,7 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7ff2960..921225f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -44,6 +44,17 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1300000000>;
+			voltage-tolerance = <1>; /* 1% */
+			clocks = <&cpg_clocks R8A7790_CLK_Z>;
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1300000 1000000>,
+					   <1150000 1000000>,
+					   < 975000 1000000>,
+					   < 770000 1000000>,
+					   < 650000 1000000>,
+					   < 325000 1000000>;
 		};
 
 		cpu1: cpu@1 {
-- 
1.7.9.5

