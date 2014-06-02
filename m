From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 02 Jun 2014 13:42:11 +0000
Subject: [PATCH v2 7/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
Message-Id: <1401716531-29794-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a DMA property to the QSPI node

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - QSPI needs to use 8-bit accesses for DMA, not 32-bit,
  - Reorder: TX first, RX second.

 arch/arm/boot/dts/r8a7791.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 37685ef32ea0..6c285ffc46cb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -917,6 +917,9 @@
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		dmas = <&dma0 R8A7791_DMA_QSPI_TX CHCR_TX_8BIT>,
+		       <&dma0 R8A7791_DMA_QSPI_RX CHCR_RX_8BIT>;
+		dma-names = "tx", "rx";
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1

