From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:19 +0000
Subject: [PATCH 45/69] ARM: shmobile: Add r8a7790 thermal device node to DTS
Message-Id: <03e2f56b8f68594ccae4b219a2693c938a04c51e.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up the r8a7790 thermal sensor to the DTS.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3800952..f844b63 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -162,6 +162,13 @@
 		interrupt-controller;
 	};
 
+	thermal@e61f0000 {
+		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
1.8.4

