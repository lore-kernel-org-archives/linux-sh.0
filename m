From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:54 +0000
Subject: [PATCH 11/15] ARM: shmobile: silk: Move SPI FLASH partitions to subnode
Message-Id: <99e14b36594cb6d6fb59aa44999c1f72508af348.1448586938.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support partitions
in a special 'partitions' subnode"), having partitions as direct subnodes
of an mtd device is discouraged. Hence move the SPI FLASH partitions to a
"partitions" subnode.

Based on similar work for the koelsch board by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index a49942b626c8..58f0ddf21c17 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -194,8 +194,6 @@
 	status = "okay";
 
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -205,19 +203,24 @@
 		spi-cpha;
 		m25p,fast-read;
 
-		partition@0 {
-			label = "loader";
-			reg = <0x00000000 0x00040000>;
-			read-only;
-		};
-		partition@40000 {
-			label = "user";
-			reg = <0x00040000 0x00400000>;
-			read-only;
-		};
-		partition@440000 {
-			label = "flash";
-			reg = <0x00440000 0x03bc0000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "loader";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition@40000 {
+				label = "user";
+				reg = <0x00040000 0x00400000>;
+				read-only;
+			};
+			partition@440000 {
+				label = "flash";
+				reg = <0x00440000 0x03bc0000>;
+			};
 		};
 	};
 };
-- 
2.1.4

