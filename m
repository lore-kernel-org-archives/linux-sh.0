From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:45:03 +0000
Subject: [PATCH] ARM: shmobile: sh73a0: add PMU information to sh73a0.dtsi
Message-Id: <20130724034503.30609.21892.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: koba@kmckk.co.jp, Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to sh73a0.dtsi. With this
included KZM9G DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/sh73a0.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/boot/dts/sh73a0.dtsi
+++ work/arch/arm/boot/dts/sh73a0.dtsi	2013-07-24 04:12:57.000000000 +0900
@@ -38,6 +38,12 @@
 		      <0xf0000100 0x100>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 55 4>,
+			     <0 56 4>;
+	};
+
 	irqpin0: irqpin@e6900000 {
 		compatible = "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
