From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Feb 2014 06:12:45 +0000
Subject: [PATCH 04/13] ARM: shmobile: r8a7778 dtsi: Remove duplicate i2c nodes
Message-Id: <08517b212726e90b1755e3c917ba064b24e97cbe.1392961872.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

"ARM: shmobile: r8a7778: add I2C support on DTSI" was applied twice:

    commit ae4273ec7b25c8b9c895a4aae31f2fced980b7bf
    commit 3acb51b9215bd99da403ecf8200f8425176b1926

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ddb3bd7..85c5b3b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -203,46 +203,6 @@
 		status = "disabled";
 	};
 
-	i2c0: i2c@ffc70000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
-		reg = <0xffc70000 0x1000>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	i2c1: i2c@ffc71000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
-		reg = <0xffc71000 0x1000>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	i2c2: i2c@ffc72000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
-		reg = <0xffc72000 0x1000>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
-	i2c3: i2c@ffc73000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
-		reg = <0xffc73000 0x1000>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
 	hspi0: spi@fffc7000 {
 		compatible = "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-- 
1.8.5.2

