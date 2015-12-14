From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 14 Dec 2015 18:58:17 +0000
Subject: [PATCH v2 2/9] ARM: shmobile: bockw dts: Enable SCIF_CLK frequency and pins
Message-Id: <1450119504-1517-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Based on schematics, tested with remote access.

v2:
  - New.
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index b1aa025992293a58..482228b8a984656e 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -126,11 +126,19 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk";
+		renesas,function = "scif_clk";
+	};
+
 	mmc_pins: mmc {
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
@@ -177,6 +185,11 @@
 	#sound-dai-cells = <0>;
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

