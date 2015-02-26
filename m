From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 26 Feb 2015 16:42:09 +0000
Subject: [PATCH v4 4/9] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <1424968934-30577-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cameras, RTC, and ak4643 sound codec.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index c7f435c..abf3f06 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -77,6 +77,31 @@
 	clock-frequency = <33333333>;
 };
 
+&i2c0 {
+	status = "okay";
+
+	ak4643: sound-codec@12 {
+		compatible = "asahi-kasei,ak4643";
+		#sound-dai-cells = <0>;
+		reg = <0x12>;
+	};
+
+	camera@41 {
+		compatible = "oki,ml86v7667";
+		reg = <0x41>;
+	};
+
+	camera@43 {
+		compatible = "oki,ml86v7667";
+		reg = <0x43>;
+	};
+
+	rx8581: rtc@51 {
+		compatible = "epson,rx8581";
+		reg = <0x51>;
+	};
+};
+
 &mmcif {
 	pinctrl-0 = <&mmc_pins>;
 	pinctrl-names = "default";
-- 
2.2.2

