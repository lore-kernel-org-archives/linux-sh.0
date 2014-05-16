From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 May 2014 15:26:53 +0000
Subject: [PATCH/RFC 5/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
Message-Id: <1400254015-29539-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DMA property to the QSPI node

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 37685ef32ea0..5b3ac8d1391c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -917,6 +917,9 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		dmas = <&dma0 R8A7791_DMA_QSPI_RX CHCR_RX_32BIT>,
+		       <&dma0 R8A7791_DMA_QSPI_TX CHCR_TX_32BIT>;
+		dma-names = "rx", "tx";
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.9.5

