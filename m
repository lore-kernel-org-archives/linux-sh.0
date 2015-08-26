From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:51 +0000
Subject: [PATCH 5/6] arm64: renesas: salvator-x: Enable SCIF1 on serial1
Message-Id: <1440612832-17627-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable access to SCIF1 on the "DEBUG SERIAL-1" connector.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index c485440564451cbc..f75f665be676d8ac 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -17,6 +17,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		serial1 = &scif1;
 	};
 
 	chosen {
@@ -37,6 +38,10 @@
 };
 
 &pfc {
+	scif1_pins: scif1 {
+		renesas,groups = "scif1_data_a", "scif1_ctrl";
+		renesas,function = "scif1";
+	};
 	scif2_pins: scif2 {
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
@@ -60,6 +65,13 @@
 	};
 };
 
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-0 = <&scif2_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

