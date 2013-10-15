From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:44:51 +0000
Subject: [PATCH 05/17] ARM: shmobile: r8a7740: fixup DT node naming for MMCIF
Message-Id: <87bo2rdllb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges MMCIF DT node from "mmcif" to "mmc".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 5b6578d..c10cf85 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -135,7 +135,7 @@
 	status = "okay";
 };
 
-&mmcif0 {
+&mmc0 {
 	pinctrl-0 = <&mmc0_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index d384fd8..44508df 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -162,7 +162,7 @@
 		#pwm-cells = <3>;
 	};
 
-	mmcif0: mmcif@e6bd0000 {
+	mmc0: mmc@e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

