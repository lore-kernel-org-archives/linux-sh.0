From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:09:35 +0000
Subject: [PATCH 1/3] arm64: renesas: r8a7795 dtsi: Rename extal clock node
Message-Id: <1440432577-9767-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As the "extal_clk: node doesn't have a "clock-output-names" property,
it's name is taken from the device's node. Hence this should not include
the "_clk" suffix.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5ee10c375190d780..04f0d89fc20aff64 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -28,7 +28,7 @@
 		};
 	};
 
-	extal_clk: extal_clk {
+	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
-- 
1.9.1

