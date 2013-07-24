From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:59:09 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: add PMU information to r8a7740.dtsi
Message-Id: <20130724035909.30648.64982.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to r8a7740.dtsi. With this
included Armadillo800eva DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Dry coded based on data sheet, not runtime tested.

 arch/arm/boot/dts/r8a7740.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7740.dtsi
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2013-07-24 04:20:42.000000000 +0900
@@ -32,6 +32,11 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 83 4>;
+	};
+
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin@e6900000 {
 		compatible = "renesas,intc-irqpin";
