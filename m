From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 14 May 2015 01:06:55 +0000
Subject: [PATCH 26/31] ARM: shmobile: koelsch dts: Use generic names for device nodes
Message-Id: <95cfb59a27360bbfd337d011676893f2726bfb42.1431565427.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

sound-codec -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 70e9d5e9afdd..9cb8a6c8e3f1 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -522,7 +522,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
-	ak4643: sound-codec@12 {
+	ak4643: codec@12 {
 		compatible = "asahi-kasei,ak4643";
 		#sound-dai-cells = <0>;
 		reg = <0x12>;
-- 
2.1.4

