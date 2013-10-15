From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:18 +0000
Subject: [PATCH 08/17] ARM: shmobile: sh73a0: fixup DT node naming for MMCIF
Message-Id: <877gdfdlkl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges MMCIF DT node from "mmcif" to "mmc".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    6 +++---
 arch/arm/boot/dts/sh73a0.dtsi                |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index eaeebd2..2e28afd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -187,8 +187,8 @@
 	status = "okay";
 };
 
-&mmcif {
-	pinctrl-0 = <&mmcif_pins>;
+&mmc {
+	pinctrl-0 = <&mmc_pins>;
 	pinctrl-names = "default";
 
 	bus-width = <8>;
@@ -205,7 +205,7 @@
 		renesas,function = "i2c3";
 	};
 
-	mmcif_pins: mmcif {
+	mmc_pins: mmc {
 		mux {
 			renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
 			renesas,function = "mmc0";
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ead8e58..6d4a98e 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -190,7 +190,7 @@
 		status = "disabled";
 	};
 
-	mmcif: mmcif@e6bd0000 {
+	mmc: mmc@e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

