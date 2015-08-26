From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:47 +0000
Subject: [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
Message-Id: <1440612832-17627-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It's enabled by the board-specific .dts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f3c30bd51d9a063d..e9ecdf5a136837b3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -283,6 +283,7 @@
 			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
 			clock-names = "sci_ick";
 			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		usb2_phy0: usb-phy@ee080200 {
-- 
1.9.1

