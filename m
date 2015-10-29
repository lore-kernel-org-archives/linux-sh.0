From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 29 Oct 2015 19:57:34 +0000
Subject: [PATCH] ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups
Message-Id: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.

This is one of two features from the DT reference platform that are
still missing in MP.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The dependencies are now in pinctrl/for-next:
ae7465a0972aee88 pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
22768fc60abbf58b pinctrl: sh-pfc: Add macros defining GP ports with config flags

 arch/arm/boot/dts/r8a7778-bockw.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 90543b12d7e26bcb..8a540767871792c6 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -137,10 +137,14 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
-				  "sdhi0_cd";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
 	};
+	sdhi0_pup_pins: sd0_pup {
+		renesas,groups = "sdhi0_cd", "sdhi0_wp";
+		renesas,function = "sdhi0";
+		bias-pull-up;
+	};
 
 	hspi0_pins: hspi0 {
 		renesas,groups = "hspi0_a";
@@ -169,7 +173,7 @@
 };
 
 &sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
-- 
1.9.1

