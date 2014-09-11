From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 11 Sep 2014 00:57:03 +0000
Subject: [PATCH 6/7] ARM: shmobile: sh73a0: Add CMT1 device to DT
Message-Id: <6a5336a77c2caa9b0f8b3aa5c70310291ce2679d.1410396171.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1410396171.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1410396171.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 910b790..093e609 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -45,6 +45,16 @@
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cmt1: timer@e6138000 {
+		compatible = "renesas,cmt-48-sh73a0", "renesas,cmt-48";
+		reg = <0xe6138000 0x200>;
+		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+
+		renesas,channels-mask = <0x3f>;
+
+		status = "disabled";
+	};
+
 	irqpin0: irqpin@e6900000 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
-- 
2.0.1

