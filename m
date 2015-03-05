From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:58:13 +0000
Subject: [PATCH 13/16] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <95e7381b1a6dec04b17aea3fd839c4ada8c96f28.1425518338.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Cameras, RTC, and ak4643 sound codec.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 0011975..646383a 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -65,6 +65,31 @@
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
2.1.4

