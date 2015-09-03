From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 10:32:54 +0000
Subject: [PATCH v9 03/07][RFC] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
Message-Id: <20150903103254.26791.81175.sendpatchset@little-apple>
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

 Changes from V8: (Magnus Damm <damm+renesas@opensource.se>)
 - Updated to remove fuzz
 
 Changes from V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Changed order not to depend on SCIF patch(es)
 
 Based on:
  [PATCH 2/6] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0003/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-09-03 18:11:20.672366518 +0900
@@ -243,5 +243,17 @@
 				#power-domain-cells = <0>;
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
