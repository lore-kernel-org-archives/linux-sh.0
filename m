From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:55 +0000
Subject: [PATCH 12/17] ARM: shmobile: r8a7778: fixup DT node naming for MMCIF
Message-Id: <871u3ndljk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges MMCIF DT node from "mmcif" to "mmc".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |    2 +-
 arch/arm/boot/dts/r8a7778.dtsi                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index b317a1dc6..35a5f6a 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -53,7 +53,7 @@
 
 };
 
-&mmcif {
+&mmc {
 	pinctrl-0 = <&mmc_pins>;
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 322b703..c889901 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -157,7 +157,7 @@
 		status = "disabled";
 	};
 
-	mmcif: mmcif@ffe4e000 {
+	mmc: mmc@ffe4e000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

