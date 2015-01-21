From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:27:56 +0000
Subject: [PATCH 4/4 v2] ARM: shmobile: r8a7791: add SDHI DMA channels on DTSI
Message-Id: <87wq4gn4e5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/boot/dts/r8a7791.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e6d89d6..8a2fc56 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -485,6 +485,8 @@
 		reg = <0 0xee100000 0 0x328>;
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

