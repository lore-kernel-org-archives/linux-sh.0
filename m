From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:38:04 +0000
Subject: [PATCH 11/12] ARM: shmobile: marzen: tidyup DT node naming
Message-Id: <87r4bekp2w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index f7578d5..ce3fe9e 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -82,17 +82,17 @@
 		};
 	};
 
-	scif2_pins: scif2 {
+	scif2_pins: serial2 {
 		renesas,groups = "scif2_data_c";
 		renesas,function = "scif2";
 	};
 
-	scif4_pins: scif4 {
+	scif4_pins: serial4 {
 		renesas,groups = "scif4_data";
 		renesas,function = "scif4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
 				 "sdhi0_wp";
 		renesas,function = "sdhi0";
-- 
1.7.9.5

