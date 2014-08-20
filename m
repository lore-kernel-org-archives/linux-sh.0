From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:02:27 +0000
Subject: [PATCH 03/10] ARM: shmobile: r8a7778: Update DTS to include CPU frequency
Message-Id: <20140820130227.32075.16599.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the r8a7778 DTS file. This
will allow us to use the shared C code on r8a7778 and BockW
which reads out the clock frequency from DT and calculates the
delay settings from there.

Also add other missing CPU information to the r8a7778 DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7778.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7778.dtsi
+++ work/arch/arm/boot/dts/r8a7778.dtsi	2014-08-20 21:04:52.000000000 +0900
@@ -23,8 +23,14 @@
 	interrupt-parent = <&gic>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
