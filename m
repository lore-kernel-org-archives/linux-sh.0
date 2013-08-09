From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Aug 2013 10:08:07 +0000
Subject: [PATCH 02/02] ARM: shmobile: Add r8a7790 CA15 CPU cores and APMU as DTS
Message-Id: <20130809100807.10827.89924.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130809100744.10827.62207.sendpatchset@w520>
In-Reply-To: <20130809100744.10827.62207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a7790 for a total of 4 x CA15
and also add an APMU node for SMP power management.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-08-07 20:14:31.000000000 +0900
@@ -24,6 +24,33 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
+	};
+
+	apmu@e6152000 {
+		compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x88>;
+		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
 	};
 
 	gic: interrupt-controller@f1001000 {
