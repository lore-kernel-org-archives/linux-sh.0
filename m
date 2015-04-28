From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 28 Apr 2015 10:29:23 +0000
Subject: [PATCH 3/3] ARM: shmobile: koelsch dts: Use generic names for device nodes
Message-Id: <1430216963-8161-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

sound-codec -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74c3212f1f11e47e..f790c2466939c5ee 100644
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
1.9.1

