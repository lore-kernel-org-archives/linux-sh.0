From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:18 +0000
Subject: [PATCH 10/10] arm64: renesas: r8a7795: fix SATA clock assignment
Message-Id: <2eb2b5066197eab00c55dcd1132f17836e4975b2.1450401186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

SATA clock is 815, not 915.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 9ce6a5ea6629..bb353cde1253 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -772,7 +772,7 @@
 			compatible = "renesas,sata-r8a7795";
 			reg = <0 0xee300000 0 0x1fff>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>;
+			clocks = <&cpg CPG_MOD 815>;
 			status = "disabled";
 		};
 	};
-- 
2.1.4

