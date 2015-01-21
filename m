From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 21 Jan 2015 16:20:57 +0000
Subject: [PATCH 06/11] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <1421857262-16607-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370593329-27559-7-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370593329-27559-7-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cameras, RTC, and ak4643 sound codec.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 7347223..280a922 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -59,6 +59,31 @@
 	};
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

