From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:46:20 +0000
Subject: [PATCH 15/17] ARM: shmobile: r8a7790: fixup DT node naming for SCIF
Message-Id: <87wqlfc6yf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SCIF DT node from "scif" to "serial".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index 75730f5..7072371 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -54,15 +54,15 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-0 = <&serial0_pins &serial1_pins>;
 	pinctrl-names = "default";
 
-	scif0_pins: scif0 {
+	serial0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
 	};
 
-	scif1_pins: scif1 {
+	serial1_pins: serial1 {
 		renesas,groups = "scif1_data";
 		renesas,function = "scif1";
 	};
-- 
1.7.9.5

