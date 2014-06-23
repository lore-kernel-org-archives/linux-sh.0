From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:48 +0000
Subject: [PATCH 1/9] ARM: shmobile: Update EMEV2 DTS to include CPU frequency
Message-Id: <11f1ca10b668995a031aade5c2728f0a251aaec7.1403487831.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the EMEV2 DTS file. This
will allow us to use the shared C code to on EMEV2 which
reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index e37985f..00eeed3 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -31,11 +31,13 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <533000000>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clock-frequency = <533000000>;
 		};
 	};
 
-- 
2.0.0.rc2

