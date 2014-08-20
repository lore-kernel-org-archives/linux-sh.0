From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 12:59:55 +0000
Subject: [PATCH 01/10] ARM: shmobile: sh7372: Update DTS to include CPU frequency
Message-Id: <20140820130210.32075.68195.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the sh7372 DTS file. This
will allow us to use the shared C code on sh7372 and Mackerel
which reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/sh7372.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/boot/dts/sh7372.dtsi
+++ work/arch/arm/boot/dts/sh7372.dtsi	2014-08-20 21:00:26.000000000 +0900
@@ -21,6 +21,7 @@
 			compatible = "arm,cortex-a8";
 			device_type = "cpu";
 			reg = <0x0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
