From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 24 Jul 2015 15:21:57 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups
Message-Id: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.

This is one of two features from the DT reference platform that are
still missing in MP.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 7df5036..13645db 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -154,10 +154,14 @@
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
@@ -186,7 +190,7 @@
 };
 
 &sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
-- 
2.4.6

