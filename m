From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 26 Aug 2014 05:23:59 +0000
Subject: [PATCH 5/8] ARM: shmobile: r8a7740: Add CMT1 device to DT
Message-Id: <c10df265febc7e46a60b129756915ad1d4d13e27.1409030383.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add the CMT1 counters to the r8a7740 device tree and make it
disabled by default.

Based on work by Magnus Damm.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 6cd6a46..1067a96 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -41,6 +41,18 @@
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cmt1: timer@e6138000 {
+		compatible = "renesas,cmt-48";
+		reg = <0xe6138000 0x170>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7740_CLK_CMT1>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0x3f>;
+
+		status = "disabled";
+	};
+
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin@e6900000 {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
-- 
2.0.1

