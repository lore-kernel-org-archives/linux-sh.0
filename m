From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:38:16 +0000
Subject: [PATCH 12/12] ARM: shmobile: lager: tidyup DT node naming
Message-Id: <87ppqykp2i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index 75730f5..ec82674 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -57,12 +57,12 @@
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
-	scif0_pins: scif0 {
+	scif0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
 	};
 
-	scif1_pins: scif1 {
+	scif1_pins: serial1 {
 		renesas,groups = "scif1_data";
 		renesas,function = "scif1";
 	};
-- 
1.7.9.5

