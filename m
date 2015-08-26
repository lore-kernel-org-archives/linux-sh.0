From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:48 +0000
Subject: [PATCH 2/6] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
Message-Id: <1440612832-17627-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add dummy nodes for the 3 DMA controllers.
This allows to start describing DMA channels for DMA slaves now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e9ecdf5a136837b3..449472c3e5362c0d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -276,6 +276,18 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
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
+
 		scif2: serial@e6e88000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
-- 
1.9.1

