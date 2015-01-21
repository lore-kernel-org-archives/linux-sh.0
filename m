From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:27:37 +0000
Subject: [PATCH 3/4 v2] ARM: shmobile: r8a7790: add SDHI DMA channels on DTSI
Message-Id: <87y4own4en.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sj2wnqiv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj2wnqiv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/boot/dts/r8a7790.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0010600..56847bf 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -496,6 +496,8 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -504,6 +506,8 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -512,6 +516,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -520,6 +526,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.7.9.5

