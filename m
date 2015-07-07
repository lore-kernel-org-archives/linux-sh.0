From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 07 Jul 2015 14:10:15 +0000
Subject: [PATCH/RFC 09/11] ARM: shmobile: r8a7794: Link CPG to RST using "renesas,modemr"
Message-Id: <1436278217-20522-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a link from the Clock Pulse Generator node to the Reset Controller
node, so the CPG can read the Mode Monitoring Register (MODEMR) to
obtain MD pin values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index bd37ec229329ed9c..e4cddf164330e77b 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -484,6 +484,7 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z";
 			#power-domain-cells = <0>;
+			renesas,modemr = <&rst 0x60>;
 		};
 		/* Variable factor clocks */
 		sd2_clk: sd2_clk@e6150078 {
-- 
1.9.1

