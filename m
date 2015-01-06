From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:05 +0000
Subject: [PATCH 2/6] ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
Message-Id: <1420573329-12762-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

While at it rename the ak4648 node to "codec" to describe the device's
function instead of its model, and move its device-specific property
after its generic properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index b6c292f839584343..02fc265332e8fb84 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -188,6 +188,13 @@
 
 &i2c0 {
 	status = "okay";
+
+	ak4648: codec@12 {
+		compatible = "asahi-kasei,ak4648";
+		reg = <0x12>;
+		#sound-dai-cells = <0>;
+	};
+
 	as3711@40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
@@ -258,12 +265,6 @@
 			};
 		};
 	};
-
-	ak4648: ak4648@12 {
-		#sound-dai-cells = <0>;
-		compatible = "asahi-kasei,ak4648";
-		reg = <0x12>;
-	};
 };
 
 &i2c3 {
-- 
1.9.1

