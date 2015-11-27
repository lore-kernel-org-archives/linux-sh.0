From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:51 +0000
Subject: [PATCH 08/15] ARM: shmobile: bockw: Move SPI FLASH partition to subnode
Message-Id: <a7d57eec21d06cae06f03bd5ae47080a3dc3e898.1448586938.git.horms+renesas@verge.net.au>
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
of an mtd device is discouraged. Hence move the SPI FLASH partition to a
"partitions" subnode.

Based on similar work for the koelsch board by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 8a5407678717..3c03e6b8261e 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -188,16 +188,19 @@
 	status = "okay";
 
 	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl008k", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
 
-		partition@0 {
-			label = "data(spi)";
-			reg = <0x00000000 0x00100000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "data(spi)";
+				reg = <0x00000000 0x00100000>;
+			};
 		};
 	};
 };
-- 
2.1.4

