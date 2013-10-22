From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:37:26 +0000
Subject: [PATCH 08/12] ARM: shmobile: ape6evm: tidyup DT node naming
Message-Id: <87vc0qkp3w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 9443e93..25dbc1c 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -88,22 +88,22 @@
 	pinctrl-0 = <&scifa0_pins>;
 	pinctrl-names = "default";
 
-	scifa0_pins: scifa0 {
+	scifa0_pins: serial0 {
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
 
-	mmc0_pins: mmcif {
+	mmc0_pins: mmc {
 		renesas,groups = "mmc0_data8", "mmc0_ctrl";
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi1_pins: sdhi1 {
+	sdhi1_pins: sd1 {
 		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
 		renesas,function = "sdhi1";
 	};
-- 
1.7.9.5

