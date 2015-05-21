From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2015 01:22:10 +0000
Subject: [PATCH 03/04] ARM: shmobile: Add APMU nodes to r8a7791 DTSI
Message-Id: <20150521012210.25972.75551.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150521012138.25972.91336.sendpatchset@little-apple>
In-Reply-To: <20150521012138.25972.91336.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add an APMU DT node for the r8a7791 SoC and use the enable-method to
point out that the APMU should be used for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-05-20 22:36:19.432366518 +0900
@@ -42,6 +42,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -69,6 +70,12 @@
 		};
 	};
 
+	apmu@e6152000 {
+		compatible = "renesas,apmu-r8a7791", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
