From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 23 Aug 2015 07:25:00 +0000
Subject: [PATCH v2 03/07] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
Message-Id: <20150823072500.14156.35604.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
In-Reply-To: <20150823072427.14156.1960.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add an APMU DT node for the r8a7790 SoC and use the enable-method to
point out that the APMU should be used for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes from V1:
 - New patch

 arch/arm/boot/dts/r8a7790.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-08-23 15:51:24.132366518 +0900
@@ -43,6 +43,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -112,6 +113,18 @@
 		};
 	};
 
+	apmu@e6151000 {
+		compatible = "renesas,apmu-r8a7790", "renesas,apmu";
+		reg = <0 0xe6151000 0 0x188>;
+		cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+	};
+
+	apmu@e6152000 {
+		compatible = "renesas,apmu-r8a7790", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
