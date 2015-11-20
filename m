From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 19:38:54 +0000
Subject: [PATCH 3/4] ARM: shmobile: porter: Move SPI FLASH partitions to subnode
Message-Id: <1448048335-23927-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
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

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* Compile tested only
---
 arch/arm/boot/dts/r8a7791-porter.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 3e198e7b3ee4..f2dd5356eac8 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -192,8 +192,6 @@
 	status = "okay";
 
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -201,19 +199,24 @@
 		spi-rx-bus-width = <4>;
 		m25p,fast-read;
 
-		partition@0 {
-			label = "loader_prg";
-			reg = <0x00000000 0x00040000>;
-			read-only;
-		};
-		partition@40000 {
-			label = "user_prg";
-			reg = <0x00040000 0x00400000>;
-			read-only;
-		};
-		partition@440000 {
-			label = "flash_fs";
-			reg = <0x00440000 0x03bc0000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "loader_prg";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition@40000 {
+				label = "user_prg";
+				reg = <0x00040000 0x00400000>;
+				read-only;
+			};
+			partition@440000 {
+				label = "flash_fs";
+				reg = <0x00440000 0x03bc0000>;
+			};
 		};
 	};
 };
-- 
2.1.4

