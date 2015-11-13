From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Nov 2015 10:10:20 +0000
Subject: [PATCH v13 2/7] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
Message-Id: <1447409425-14831-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447409425-14831-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447409425-14831-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add dummy nodes for the 3 DMA controllers.
This allows to start describing DMA channels for DMA slaves now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Changes since v10:
- None

Changes from V9: (Magnus Damm <damm+renesas@opensource.se>)
- Updated to remove fuzz

Changes from V8: (Magnus Damm <damm+renesas@opensource.se>)
- Updated to remove fuzz

Changes from V7: (Magnus Damm <damm+renesas@opensource.se>)
- Changed order not to depend on SCIF patch(es)

Based on:
 [PATCH 2/6] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8d7552020daf..9e1de4d6615c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -79,5 +79,17 @@
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
+
+		dmac0: dma-controller@e6700000 {
+			/* Empty node for now */
+		};
+
+		dmac1: dma-controller@e7300000 {
+			/* Empty node for now */
+		};
+
+		dmac2: dma-controller@e7310000 {
+			/* Empty node for now */
+		};
 	};
 };
-- 
2.1.4

