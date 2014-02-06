From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:40 +0000
Subject: [PATCH 05/17] ARM: shmobile: r8a7790: Add thermal clock in device tree
Message-Id: <d3a439dbe3ff1610156c39cdffcc2c3257fadd62.1391665761.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add the missing thermal MSTP clock to the thermal device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 71b1251..96fc731 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -168,6 +168,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
 	};
 
 	timer {
-- 
1.8.5.2

