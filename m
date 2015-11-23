From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 23 Nov 2015 13:56:00 +0000
Subject: [PATCH v5 2/4] ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node
Message-Id: <1448286962-16897-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448286962-16897-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448286962-16897-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add the missing L2 cache-controller node, and link the CPU nodes to it.
This will allow migration to the generic l2c OF initialization.

The L2 cache is an ARM L2C-310 (r3p1), of size 512 KiB (64 KiB x 8
ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Drop optional cache-{size,sets,{block,line}-size} properties, as
    this information is auto-detected,
  - Integrate linking CPUs to L2 cache into this patch,

v4:
  - New.
---
 arch/arm/boot/dts/sh73a0.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index cbc885e46c504f56..f90ef9c93d3df3aa 100644
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
1.9.1

