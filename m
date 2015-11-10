From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Nov 2015 08:35:06 +0000
Subject: [PATCH] ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
Message-Id: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
partitions in a special 'partitions' subnode"), having partitions as
direct subnodes of an mtd device is discouraged:

    spi0.0: 'partitions' subnode not found on /spi@e6b10000/flash@0. Trying to parse direct subnodes as partitions.

Hence move the SPI FLASH partitions to a "partitions" subnode.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f63338ba3599ebc0..2cbd5e330c032533 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -490,8 +490,6 @@
 	status = "okay";
 
 	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -501,19 +499,24 @@
 		spi-cpol;
 		m25p,fast-read;
 
-		partition@0 {
-			label = "loader";
-			reg = <0x00000000 0x00080000>;
-			read-only;
-		};
-		partition@80000 {
-			label = "user";
-			reg = <0x00080000 0x00580000>;
-			read-only;
-		};
-		partition@600000 {
-			label = "flash";
-			reg = <0x00600000 0x03a00000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "loader";
+				reg = <0x00000000 0x00080000>;
+				read-only;
+			};
+			partition@80000 {
+				label = "user";
+				reg = <0x00080000 0x00580000>;
+				read-only;
+			};
+			partition@600000 {
+				label = "flash";
+				reg = <0x00600000 0x03a00000>;
+			};
 		};
 	};
 };
-- 
1.9.1

