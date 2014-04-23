From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:48 +0000
Subject: [PATCH 20/33] ARM: shmobile: koelsch: make i2c2-pfc node unique
Message-Id: <e6a4c001116ca28a3c5698168a2a1fe274fa6d2c.1398216022.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

This node should have a unique name so it can be distinguished when
other i2c busses are added later.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index ee23b7b..fc6c94a 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -228,7 +228,7 @@
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
-	i2c2_pins: i2c {
+	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
 	};
-- 
1.8.5.2

