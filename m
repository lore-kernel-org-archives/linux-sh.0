From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 01 Aug 2013 08:26:56 +0000
Subject: [PATCH 14/14] ARM: shmobile: r8a7779: Remove '0x's from R8A7779 DTS file
Message-Id: <98724b7ec9d34d875fc193660c87d6dd0d17ceb7.1375344714.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 7f146c6..86bd487 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -65,7 +65,7 @@
 		sense-bitfield-width = <2>;
 	};
 
-	i2c0: i2c@0xffc70000 {
+	i2c0: i2c@ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -74,7 +74,7 @@
 		interrupts = <0 79 0x4>;
 	};
 
-	i2c1: i2c@0xffc71000 {
+	i2c1: i2c@ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -83,7 +83,7 @@
 		interrupts = <0 82 0x4>;
 	};
 
-	i2c2: i2c@0xffc72000 {
+	i2c2: i2c@ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -92,7 +92,7 @@
 		interrupts = <0 80 0x4>;
 	};
 
-	i2c3: i2c@0xffc73000 {
+	i2c3: i2c@ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
-- 
1.8.3.2

