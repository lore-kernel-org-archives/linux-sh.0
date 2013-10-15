From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:44:18 +0000
Subject: [PATCH 02/17] ARM: shmobile: r8a73a4: fixup DT node naming for MMCIF
Message-Id: <87fvs3dlm9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges MMCIF DT node from "mmcif" to "mmc".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |    4 ++--
 arch/arm/boot/dts/r8a73a4.dtsi                  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 27ce4ac..a59f8f6 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -93,7 +93,7 @@
 		renesas,function = "scifa0";
 	};
 
-	mmc0_pins: mmcif {
+	mmc0_pins: mmc0 {
 		renesas,groups = "mmc0_data8", "mmc0_ctrl";
 		renesas,function = "mmc0";
 	};
@@ -109,7 +109,7 @@
 	};
 };
 
-&mmcif0 {
+&mmc0 {
 	vmmc-supply = <&vcc_mmc0>;
 	bus-width = <8>;
 	non-removable;
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 447c128..a720c22 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -219,7 +219,7 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmcif@ee200000 {
+	mmc0: mmc@ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
@@ -228,7 +228,7 @@
 		status = "disabled";
 	};
 
-	mmcif1: mmcif@ee220000 {
+	mmc1: mmc@ee220000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

