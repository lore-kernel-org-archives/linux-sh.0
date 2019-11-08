From: Sasha Levin <sashal@kernel.org>
Date: Fri, 08 Nov 2019 11:34:42 +0000
Subject: [PATCH AUTOSEL 4.19 015/205] ARM: dts: rcar: Correct SATA device sizes to 2 MiB
Message-Id: <20191108113752.12502-15-sashal@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 441f61e3aa9e7386731ce1405044d484bd81f911 ]

Update the SATA device nodes on R-Car H1, H2, and M2-W to use a 2 MiB
I/O space, as specified in Rev.1.0 of the R-Car H1 and R-Car Gen2
hardware user manuals.

See also commit e9f0089b2d8a3d45 ("arm64: dts: r8a7795: Correct SATA
device size to 2MiB").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6b997bc016ee8..03919714645ae 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -344,7 +344,7 @@
 
 	sata: sata@fc600000 {
 		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
-		reg = <0xfc600000 0x2000>;
+		reg = <0xfc600000 0x200000>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 		power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0925bdca438fe..52a757f47bf08 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1559,7 +1559,7 @@
 		sata0: sata@ee300000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
@@ -1570,7 +1570,7 @@
 		sata1: sata@ee500000 {
 			compatible = "renesas,sata-r8a7790",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 991ac6feedd5b..25b6a99dd87a2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1543,7 +1543,7 @@
 		sata0: sata@ee300000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
+			reg = <0 0xee300000 0 0x200000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
@@ -1554,7 +1554,7 @@
 		sata1: sata@ee500000 {
 			compatible = "renesas,sata-r8a7791",
 				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
+			reg = <0 0xee500000 0 0x200000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 814>;
 			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-- 
2.20.1
