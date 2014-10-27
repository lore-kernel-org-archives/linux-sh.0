From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 27 Oct 2014 09:27:13 +0000
Subject: [PATCH] ARM: shmobile: marzen: Fix address and size cells in LVDS encoder node
Message-Id: <1414402033-7311-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The LVDS encoder DT node #address-cells and #size-cells properties are
misplaced. Move them to within the ports node.

Reported-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 034dada2b462..e83d40e24bcd 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -105,10 +105,10 @@
 	lvds-encoder {
 		compatible = "thine,thc63lvdm83d";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			port@0 {
 				reg = <0>;
 				lvds_enc_in: endpoint {
-- 
Regards,

Laurent Pinchart

