From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 03:18:09 +0000
Subject: [PATCH 3/3] ARM: shmobile: sh73a0: fixup sdhi compatible name
Message-Id: <87zjoz92xd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh73a0 != r8a7740

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index aef8a61..29d2ee6 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -203,7 +203,7 @@
 	};
 
 	sdhi0: sd@ee100000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH
@@ -215,7 +215,7 @@
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
 	sdhi1: sd@ee120000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
@@ -226,7 +226,7 @@
 	};
 
 	sdhi2: sd@ee140000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
-- 
1.7.9.5

