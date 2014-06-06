From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 05:28:49 +0000
Subject: [PATCH v2 01/03] ARM: shmobile: Update r7s72100 DTS to include CPU frequency
Message-Id: <20140606052849.17594.52608.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the r7s72100 DTS file. This
will allow us to use the shared C code on r7s72100 and Genmai
which reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r7s72100.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/boot/dts/r7s72100.dtsi
+++ work/arch/arm/boot/dts/r7s72100.dtsi	2014-05-29 17:47:45.000000000 +0900
@@ -144,6 +144,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <400000000>;
 		};
 	};
 
