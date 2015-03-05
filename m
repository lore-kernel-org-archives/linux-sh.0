From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:57:57 +0000
Subject: [PATCH 05/13] ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
Message-Id: <271b3ad26187fc7b47a74510b01193b506c60dbf.1425517246.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a node for the Bus State Controller (BSC) on r8a73a4, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain C4.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fdcca5d..77bd35c 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -409,6 +409,16 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	bsc: bus@fec10000 {
+		compatible = "renesas,bsc-r8a73a4", "renesas,bsc",
+			     "simple-pm-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x20000000>;
+		reg = <0 0xfec10000 0 0x400>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4

