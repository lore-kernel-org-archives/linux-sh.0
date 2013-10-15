From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:46:12 +0000
Subject: [PATCH 14/17] ARM: shmobile: r8a7779: fixup DT node naming for SCIF
Message-Id: <87y55vc6yn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SCIF DT node from "scif" to "serial".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index cb9ff29..3acf852 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -68,7 +68,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins &scif4_pins>;
+	pinctrl-0 = <&serial2_pins &serial4_pins>;
 	pinctrl-names = "default";
 
 	lan0_pins: lan0 {
@@ -82,12 +82,12 @@
 		};
 	};
 
-	scif2_pins: scif2 {
+	serial2_pins: serial2 {
 		renesas,groups = "scif2_data_c";
 		renesas,function = "scif2";
 	};
 
-	scif4_pins: scif4 {
+	serial4_pins: serial4 {
 		renesas,groups = "scif4_data";
 		renesas,function = "scif4";
 	};
-- 
1.7.9.5

