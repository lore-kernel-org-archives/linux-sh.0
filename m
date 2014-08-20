From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Aug 2014 14:28:31 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7779 dtsi: Remove superfluous interrupt-parent
Message-Id: <1408544914-21742-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408544914-21742-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

There's already an "interrupt-parent = <&gic>;" at the top, which is
inherited by all child nodes, so the "interrupt-parent" properties in
the serial nodes can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index f9dbb7645333..ddc89000854c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -199,7 +199,6 @@
 	scif0: serial@ffe40000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -209,7 +208,6 @@
 	scif1: serial@ffe41000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -219,7 +217,6 @@
 	scif2: serial@ffe42000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -229,7 +226,6 @@
 	scif3: serial@ffe43000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -239,7 +235,6 @@
 	scif4: serial@ffe44000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
@@ -249,7 +244,6 @@
 	scif5: serial@ffe45000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg_clocks R8A7779_CLK_P>;
 		clock-names = "sci_ick";
-- 
1.9.1

