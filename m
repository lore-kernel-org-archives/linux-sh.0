From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sat, 04 Apr 2015 16:54:31 +0000
Subject: [PATCH repost] ARM: shmobile: r8a7790: Remove MSIOF address from device tree
Message-Id: <1428166471-2897-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on devel branch of Simon Horman's renesas tree.

v1 repost [Yoshihiro Kaneko]
* Dropped RFC designation

 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4bb2f4c..f3b8430 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1273,7 +1273,7 @@
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
@@ -1285,7 +1285,7 @@
 
 	msiof1: spi@e6e10000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
@@ -1297,7 +1297,7 @@
 
 	msiof2: spi@e6e00000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
@@ -1309,7 +1309,7 @@
 
 	msiof3: spi@e6c90000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6c90000 0 0x0064>, <0 0xe7c90000 0 0x0064>;
+		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
-- 
1.9.1

