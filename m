From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 06:29:41 +0000
Subject: [PATCH v8 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
Message-Id: <20150831062941.24004.65819.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add dummy nodes for the 3 DMA controllers.
This allows to start describing DMA channels for DMA slaves now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Based on:
  [PATCH 2/6] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes

 Changes: (Magnus Damm <damm+renesas@opensource.se>)
 - Changed order not to depend on SCIF patch(es)
 
arch/arm64/boot/dts/renesas/r8a7795.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0010/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-08-29 15:26:42.172366518 +0900
@@ -239,5 +239,17 @@
 						     "pll3", "pll4";
 			};
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
