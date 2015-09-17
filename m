From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 06:33:09 +0000
Subject: [PATCH v3 03/09] ARM: shmobile: Add APMU nodes to r8a7793 DTSI
Message-Id: <20150917063309.26016.5367.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
In-Reply-To: <20150917063240.26016.93772.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add an APMU DT node for the r8a7793 SoC and use the enable-method to
point out that the APMU should be used for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes from V2:
 - New patch

 arch/arm/boot/dts/r8a7793.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-09-16 20:53:27.660513000 +0900
@@ -21,6 +21,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -39,6 +40,19 @@
 					   < 750000 1000000>,
 					   < 375000 1000000>;
 		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+		};
+	};
+
+	apmu@e6152000 {
+		compatible = "renesas,apmu-r8a7793", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
 	};
 
 	gic: interrupt-controller@f1001000 {
