From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 04:09:41 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
Message-Id: <87k30flakj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d2b541c98f5402ebb49ee1c636ef5bc31462b4ca.1421371490.git.horms+renesas@verge.net.au>
In-Reply-To: <d2b541c98f5402ebb49ee1c636ef5bc31462b4ca.1421371490.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7791 SDHI ch0/ch1 has SD_DMACR which is located in 0x324.
This patch updates register size

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3c45d9b..8a2fc56 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -482,7 +482,7 @@
 
 	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7791";
-		reg = <0 0xee100000 0 0x200>;
+		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
-- 
1.7.9.5

