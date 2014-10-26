From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 17:40:13 +0000
Subject: [PATCH v3 6/9] ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
Message-Id: <1414345216-14486-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add references to the transmit and receive DMA channels in the two
MMCIF nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0403e80e467d..b800284b9195 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -397,6 +397,8 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
+		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -406,6 +408,8 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
+		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
 	};
-- 
2.0.4

