From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:09:36 +0000
Subject: [PATCH 2/3] arm64: renesas: r8a7795 dtsi: Extal clock must be overridden
Message-Id: <1440432577-9767-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a note that the "extal" clock for the external crystal oscillator
must be overridden by a board-specific .dts file, else its clock rate
will be zero.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 04f0d89fc20aff64..46e68c040cc925dd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -31,6 +31,7 @@
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
+		/* This value must be overridden by the board */
 		clock-frequency = <0>;
 	};
 
-- 
1.9.1

