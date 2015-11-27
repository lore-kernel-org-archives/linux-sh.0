From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:28 +0000
Subject: [PATCH 11/18] arm64: renesas: r8a7795: Sound SSI DMA support
Message-Id: <10d18ab8392bb6e81224f37054693a0ea4366a0c.1448587800.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448587800.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 15753f4dcf4e..5d684e961675 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -599,33 +599,53 @@
 			rcar_sound,ssi {
 				ssi0: ssi@0 {
 					interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi1: ssi@1 {
 					 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi2: ssi@2 {
 					interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi3: ssi@3 {
 					interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi4: ssi@4 {
 					interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi5: ssi@5 {
 					interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi6: ssi@6 {
 					interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi7: ssi@7 {
 					interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi8: ssi@8 {
 					interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi9: ssi@9 {
 					interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
 		};
-- 
2.1.4

