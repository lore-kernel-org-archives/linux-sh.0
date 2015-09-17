From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:32:00 +0000
Subject: [PATCH 13/20 v2] arm64: renesas: salvator-x: enable I2C
Message-Id: <87eghx7jr0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2

 - add Acked-by Geert
 - clock-frequency = <100000> will be added in other patch

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 3f45d56..de7561e5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -98,6 +98,11 @@
 		renesas,groups = "avb_mdc";
 		renesas,function = "avb";
 	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2_a";
+		renesas,function = "i2c2";
+	};
 };
 
 &scif1 {
@@ -141,3 +146,10 @@
 	};
 
 };
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
1.9.1

