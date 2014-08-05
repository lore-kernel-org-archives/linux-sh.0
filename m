From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Aug 2014 03:17:32 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7791: add generation level compatible for SDHI
Message-Id: <87ppgfocad.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "goda (Renesas)" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1e97113..82be0af 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -341,7 +341,7 @@
 	};
 
 	sdhi0: sd@ee100000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791", "renesas,sdhi-rcar-gen2";
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
@@ -349,7 +349,7 @@
 	};
 
 	sdhi1: sd@ee140000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791", "renesas,sdhi-rcar-gen2";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
@@ -357,7 +357,7 @@
 	};
 
 	sdhi2: sd@ee160000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791", "renesas,sdhi-rcar-gen2";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
-- 
1.7.9.5

