From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Sep 2014 09:13:01 +0000
Subject: [PATCH v2 05/10] ARM: shmobile: sh73a0: Add CMT1 device to DT
Message-Id: <1409649186-1046-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index dad8404..39cb4cf 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -49,6 +49,18 @@
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cmt1: timer@e6138000 {
+		compatible = "renesas,cmt-48";
+		reg = <0xe6138000 0x200>;
+		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
+		clock-names = "fck";
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
1.8.4.5

