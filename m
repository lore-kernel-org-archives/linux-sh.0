From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:02:19 +0000
Subject: [PATCH 02/10] ARM: shmobile: sh73a0: Update DTS to include CPU frequency
Message-Id: <20140820130219.32075.81653.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the sh73a0 DTS file. This
will allow us to use the shared C code on sh73a0 and KZM9G
which reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/sh73a0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/boot/dts/sh73a0.dtsi
+++ work/arch/arm/boot/dts/sh73a0.dtsi	2014-08-20 21:10:17.000000000 +0900
@@ -23,11 +23,13 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <1196000000>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clock-frequency = <1196000000>;
 		};
 	};
 
