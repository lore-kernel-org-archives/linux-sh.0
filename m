From: Benoit Cousson <bcousson@baylibre.com>
Date: Wed, 26 Feb 2014 23:09:48 +0000
Subject: [RFC 2/4] ARM: dts: r8a7790-lager: Add DVFS parameters into cpu0 node for r8a7790
Message-Id: <1393456190-7870-3-git-send-email-bcousson@baylibre.com>
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
 arch/arm/boot/dts/r8a7790-lager.dts |  4 ++++
 arch/arm/boot/dts/r8a7790.dtsi      | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5f77e3a..2f122ff 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -261,3 +261,7 @@
 		regulator-always-on;
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 618e5b5..1f4c4d6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -35,6 +35,17 @@
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
1.8.3.2

