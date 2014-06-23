From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:16 +0000
Subject: [PATCH 03/24] ARM: shmobile: marzen: Specify external clock frequency in DT
Message-Id: <954e42cf541b3cbb8dd07ba29f5974f91cb8c248.1403487423.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The external crystal frequency is 31.25 on the Marzen board.
Specify it in the device tree.

Based on work for the Lager board by Laurent Pinchart.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index ddf9b9e..363f693 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -69,6 +69,10 @@
 	status = "okay";
 };
 
+&extal_clk {
+	clock-frequency = <31250000>;
+};
+
 &pfc {
 	pinctrl-0 = <&scif2_pins &scif4_pins>;
 	pinctrl-names = "default";
-- 
2.0.0.rc2

