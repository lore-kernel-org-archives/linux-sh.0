From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 May 2014 15:26:54 +0000
Subject: [PATCH/RFC 6/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
Message-Id: <1400254015-29539-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA properties to the MSIOF nodes

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 5b3ac8d1391c..66bf2f8cd259 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -931,6 +931,9 @@
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF0_RX CHCR_RX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF0_TX CHCR_TX_32BIT>;
+		dma-names = "rx", "tx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -941,6 +944,9 @@
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF1_RX CHCR_RX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF1_TX CHCR_TX_32BIT>;
+		dma-names = "rx", "tx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -951,6 +957,9 @@
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF2_RX CHCR_RX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF2_TX CHCR_TX_32BIT>;
+		dma-names = "rx", "tx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
1.7.9.5

