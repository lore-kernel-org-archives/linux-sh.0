From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:46:39 +0000
Subject: [PATCH 17/17] ARM: shmobile: r8a7790: fixup DT node naming for MMCIF
Message-Id: <87txgjc6xx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges MMCIF DT node from "mmcif" to "mmc".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts |    2 +-
 arch/arm/boot/dts/r8a7790.dtsi                |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index 7072371..dfd4a2a 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -73,7 +73,7 @@
 	};
 };
 
-&mmcif1 {
+&mmc1 {
 	pinctrl-0 = <&mmc1_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 72542ee..8095529 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -216,7 +216,7 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmcif@ee200000 {
+	mmc0: mmc@ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -225,7 +225,7 @@
 		status = "disabled";
 	};
 
-	mmcif1: mmcif@ee220000 {
+	mmc1: mmc@ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

