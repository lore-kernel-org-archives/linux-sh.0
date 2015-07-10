From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 10 Jul 2015 06:37:18 +0000
Subject: [PATCH 10/11] ARM: shmobile: r8a7794 dtsi: Use "arm,gic-400" for GIC
Message-Id: <c73ddf42e7a93dabf918b22d3cc2ce02b90d4155.1436509954.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1436509954.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1436509954.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the "arm,cortex-a15-gic" compatible value for the GIC by
"arm,gic-400", as the R-Car Gen2 GIC is assumed to be a GIC-400.
This has been confirmed by reading the GICD_IIDR register (on r8a7791),
which reports 0x0200043b (GIC-400 = 0x02, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index b73819423311..8824dbd5dbb4 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -39,7 +39,7 @@
 	};
 
 	gic: interrupt-controller@f1001000 {
-		compatible = "arm,cortex-a7-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-- 
2.1.4

