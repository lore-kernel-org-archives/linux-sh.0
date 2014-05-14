From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 May 2014 14:41:12 +0000
Subject: [PATCH] ARM: shmobile: r8a7740 dtsi: Remove duplicate interrupt-parent property
Message-Id: <1400078472-4630-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Caused by interaction between commit
08ec67b50db7ca8c9077e67ca23850cdc5bfc716 ("ARM: shmobile: r8a7740 dtsi:
Add Ethernet support") and commit 9ff254adc1e32db46000a33b8ecbc4d7047672be
("ARM: shmobile: dts: Move interrupt-parent property to root node").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Can this still be folded into the latter commit?

 arch/arm/boot/dts/r8a7740.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index ce7a0b29ae7c..55d29f4d2ed6 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -124,7 +124,6 @@
 		compatible = "renesas,gether-r8a7740";
 		reg = <0xe9a00000 0x800>,
 		      <0xe9a01800 0x800>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
 		/* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */
 		phy-mode = "mii";
-- 
1.7.9.5

