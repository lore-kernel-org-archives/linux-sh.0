From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:36:48 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: removed unnecessary mmc option
Message-Id: <871tzo7lw2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<8761p07lx8.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761p07lx8.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7790 specific MMC options are cared by driver.
This driver removes these from DTSI

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f48487c..df578cd 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -265,7 +265,6 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -275,7 +274,6 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -285,7 +283,6 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -295,7 +292,6 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
-- 
1.7.9.5

