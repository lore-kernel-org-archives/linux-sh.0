From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:28:34 +0000
Subject: [GIT PULL 13/19] ARM: shmobile: sh73a0: add PMU information to sh73a0.dtsi
Message-Id: <4c90483a9c09ac8c18df43901c493e546bdaaabe.1375838900.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to sh73a0.dtsi. With this
included KZM9G DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b977502..7137c0f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
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
-- 
1.8.3.2

