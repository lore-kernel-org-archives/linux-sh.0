From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:00 +0000
Subject: [PATCH 06/17] ARM: shmobile: r8a7740: fixup DT node naming for SCIFA
Message-Id: <87a9ibdll2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SCIFA DT node from "scifa" to "serial".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c10cf85..9dc57f0 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -102,10 +102,10 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa1_pins>;
+	pinctrl-0 = <&serial1_pins>;
 	pinctrl-names = "default";
 
-	scifa1_pins: scifa1 {
+	serial1_pins: serial1 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
 	};
-- 
1.7.9.5

