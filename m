From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Apr 2013 07:11:22 +0000
Subject: [PATCH 3/4] ARM: shmobile: move r8a7740 DMA controller DT node under a "dma-mux" node
Message-Id: <1367305883-2997-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1367305883-2997-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1367305883-2997-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On r8a7740 multiple DMA controllers can serve the same slaves with the
same DMA slave IDs. To use this feature DMA controller DT nodes have
to be grouped under "dma-mux" multiplexer nodes and slaves have to be
modified to reference multiplexer nodes instead of individual DMA DT
nodes. Future patches shall add further DMA controller DT nodes under
the same DMA multiplexer DT node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Applies on top of my earlier "ARM: shmobile: r8a7740: add DT node for one 
DMAC instance" patch still under review.

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   12 +++---
 arch/arm/boot/dts/r8a7740.dtsi                     |   43 +++++++++++--------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c201445..1983d49 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -47,8 +47,8 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
 	non-removable;
-	dmas = <&dma0 0xd1
-		&dma0 0xd2>;
+	dmas = <&dmac 0xd1
+		&dmac 0xd2>;
 	dma-names = "tx", "rx";
 	status = "okay";
 };
@@ -57,8 +57,8 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
 	broken-cd;
-	dmas = <&dma0 0xc1
-		&dma0 0xc2>;
+	dmas = <&dmac 0xc1
+		&dmac 0xc2>;
 	dma-names = "tx", "rx";
 	status = "okay";
 };
@@ -66,8 +66,8 @@
 &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
-	dmas = <&dma0 0xc9
-		&dma0 0xca>;
+	dmas = <&dmac 0xc9
+		&dmac 0xca>;
 	dma-names = "tx", "rx";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 054bc1a..965ca4c 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -112,24 +112,31 @@
 			      0 149 0x4>;
 	};
 
-	dma0: shdma@fe008020 {
-		compatible = "renesas,shdma";
-		reg = <0xfe008020 0x270
-			0xfe009000 0xc>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 34 4
-				0 28 4
-				0 29 4
-				0 30 4
-				0 31 4
-				0 32 4
-				0 33 4>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5";
-		#dma-cells = <1>;
-		dma-channels = <6>;
-		dma-requests = <256>;
+	dmac: dma-mux0 {
+		compatible = "simple-bus", "dma-mux";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dma0: shdma@fe008020 {
+			compatible = "renesas,shdma";
+			reg = <0xfe008020 0x270>,
+				<0xfe009000 0xc>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 34 4
+					0 28 4
+					0 29 4
+					0 30 4
+					0 31 4
+					0 32 4
+					0 33 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5";
+			#dma-cells = <1>;
+			dma-channels = <6>;
+			dma-requests = <256>;
+		};
 	};
 
 	i2c0: i2c@fff20000 {
-- 
1.7.2.5

