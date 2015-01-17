From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 17 Jan 2015 00:58:42 +0000
Subject: [PATCH 09/11] ARM: shmobile: r8a7740 dtsi: Add memory-controller node
Message-Id: <f4c6d004eac803cf90452c94ec5f3210c2d44c01.1421380713.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the DDR3 Bus State Controller (DBSC3).
The DBSC3 is located in the A4S PM domain, which must not be powered
down, else the system will crash.

This has no visible effect for now, as A4S was never turned off anyway
because its child PM domain A3SM contains the CPU core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 52f2cf4..8a09260 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -37,6 +37,12 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	dbsc3: memory-controller@fe400000 {
+		compatible = "renesas,dbsc3-r8a7740";
+		reg = <0xfe400000 0x400>;
+		power-domains = <&pd_a4s>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4

