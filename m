From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:16:48 +0000
Subject: [PATCH 07/14][RFC] arm64: renesas: salvator-x: enable I2C
Message-Id: <87h9n2n3x1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index f522fda..0599b2b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -45,6 +45,11 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2_a";
+		renesas,function = "i2c2";
+	};
 };
 
 &scif1 {
@@ -60,3 +65,10 @@
 
 	status = "okay";
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

