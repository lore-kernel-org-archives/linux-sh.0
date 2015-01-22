From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 04:09:22 +0000
Subject: [PATCH 2/4 v3] ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
Message-Id: <87mw5blal2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add references to the transmit and receive DMA channels in the three
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - use Laurent's original patch

 arch/arm/boot/dts/r8a7791.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e35812a..3c45d9b 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -485,6 +485,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -493,6 +495,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -501,6 +505,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.7.9.5

