From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 10 Nov 2014 01:32:20 +0000
Subject: [PATCH 3/8] ARM: shmobile: r8a7790 dtsi: Remove unnecessary MMC options
Message-Id: <a6190fd042c19e1abd0b7225e75929e5005587c9.1415582842.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As of commit 423f6c2e977de73b ("mmc: sdhi: update sh_mobile_sdhi_of_data
for r8a7790"), the driver takes care of r8a7790 specific MMC options.
Hence they can be removed from the dtsi.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Rebased, reworded, added reference]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: Rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d0e1773..2be9122 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -420,7 +420,6 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -429,7 +428,6 @@
 		reg = <0 0xee120000 0 0x200>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -438,7 +436,6 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -447,7 +444,6 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
-- 
2.1.1

