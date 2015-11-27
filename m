From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:58 +0000
Subject: [PATCH 15/15] ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node
Message-Id: <c8d9fdbe2d648caaa510d45dc13eba2e9957140b.1448586938.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the missing L2 cache-controller node, and link the CPU nodes to it.
This will allow migration to the generic l2c OF initialization.

The L2 cache is an ARM L2C-310 (r3p1), of size 512 KiB (64 KiB x 8
ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ff7c8f298f30..319551f0fcdb 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -28,6 +28,7 @@
 			reg = <0>;
 			clock-frequency = <1196000000>;
 			power-domains = <&pd_a2sl>;
+			next-level-cache = <&L2>;
 		};
 		cpu@1 {
 			device_type = "cpu";
@@ -35,6 +36,7 @@
 			reg = <1>;
 			clock-frequency = <1196000000>;
 			power-domains = <&pd_a2sl>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -53,6 +55,18 @@
 		      <0xf0000100 0x100>;
 	};
 
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xf0100000 0x1000>;
+		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_a3sm>;
+		arm,data-latency = <3 3 3>;
+		arm,tag-latency = <2 2 2>;
+		arm,shared-override;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	sbsc2: memory-controller@fb400000 {
 		compatible = "renesas,sbsc-sh73a0";
 		reg = <0xfb400000 0x400>;
-- 
2.1.4

