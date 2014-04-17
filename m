From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 00:32:11 +0000
Subject: [PATCH 3/5] ARM: shmobile: sh73a0: drop address cells from GIC node
Message-Id: <de66b584042b8f2cfe4c34ef4faa804dcd8d5843.1397694064.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397694064.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397694064.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b7bd3b9..5ecf552 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -34,7 +34,6 @@
 	gic: interrupt-controller@f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0xf0001000 0x1000>,
 		      <0xf0000100 0x100>;
-- 
1.8.4

