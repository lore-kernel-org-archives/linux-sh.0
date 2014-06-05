From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:31:56 +0000
Subject: [PATCH 01/03] ARM: shmobile: Update EMEV2 DTS to include CPU frequency
Message-Id: <20140605053156.19066.68800.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the EMEV2 DTS file. This
will allow us to use the shared C code to on EMEV2 which
reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/emev2.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/boot/dts/emev2.dtsi
+++ work/arch/arm/boot/dts/emev2.dtsi	2014-05-29 17:06:48.000000000 +0900
@@ -31,11 +31,13 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <533000000>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clock-frequency = <533000000>;
 		};
 	};
 
