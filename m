From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:37:39 +0000
Subject: [PATCH 09/12] ARM: shmobile: kzm9g: tidyup DT node naming
Message-Id: <87txgakp3j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8ee06dd..df75aea 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -205,7 +205,7 @@
 		renesas,function = "i2c3";
 	};
 
-	mmcif_pins: mmcif {
+	mmcif_pins: mmc {
 		mux {
 			renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
 			renesas,function = "mmc0";
@@ -217,17 +217,17 @@
 		};
 	};
 
-	scifa4_pins: scifa4 {
+	scifa4_pins: serial4 {
 		renesas,groups = "scifa4_data", "scifa4_ctrl";
 		renesas,function = "scifa4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi2_pins: sdhi2 {
+	sdhi2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
-- 
1.7.9.5

