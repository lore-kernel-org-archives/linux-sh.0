From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Mar 2015 01:39:55 +0000
Subject: [PATCH 4/6] ARM: shmobile: r8a7791: enable Audio DMAC peri peri via sound driver
Message-Id: <87siddsk9w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Audio DMAC peri peri is no longer DMAEngine. it is supported by
sound driver. this patch enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8631e02..a697b94 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -357,13 +357,6 @@
 		dma-channels = <13>;
 	};
 
-	audmapp: dma-controller@ec740000 {
-		compatible = "renesas,rcar-audmapp";
-		#dma-cells = <1>;
-
-		reg = <0 0xec740000 0 0x200>;
-	};
-
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
@@ -1503,8 +1496,9 @@
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x1280>; /* SSI */
-		reg-names = "scu", "adg", "ssiu", "ssi";
+			<0 0xec541000 0 0x1280>, /* SSI */
+			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7791_CLK_SSI9>, <&mstp10_clks R8A7791_CLK_SSI8>,
-- 
1.9.1

