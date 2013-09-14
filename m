From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 15:28:58 +0000
Subject: [PATCH 01/03] ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI
Message-Id: <20130914152858.12327.67427.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add r8a7790 Cortex-A7 CPU information to DTSI.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-09-15 00:09:24.000000000 +0900
@@ -45,6 +45,34 @@
 			reg = <3>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu4: cpu@4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu5: cpu@5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu6: cpu@6 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu7: cpu@7 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <780000000>;
+		};
 	};
 
 	gic: interrupt-controller@f1001000 {
