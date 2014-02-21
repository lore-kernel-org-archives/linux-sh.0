From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Feb 2014 06:12:52 +0000
Subject: [PATCH 11/13] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
Message-Id: <38c53516729925d2123ed800e5f4182d77e450a6.1392961872.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas@verge.net.au: resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f67d2d0..bf6ba0c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -108,10 +108,29 @@
 	clock-frequency = <20000000>;
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &pfc {
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	i2c2_pins: i2c {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	du_pins: du {
 		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
 		renesas,function = "du";
-- 
1.8.5.2

