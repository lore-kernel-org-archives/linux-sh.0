From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 May 2014 20:32:30 +0000
Subject: [PATCH 3/3] ARM: shmobile: armadillo-reference dts: Add Ethernet support
Message-Id: <1399494750-31996-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1399494750-31996-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399494750-31996-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bastian Hecht <hechtb+renesas@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 10344e6edd20..486007d7ffe4 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -158,6 +158,18 @@
 	};
 };
 
+&ether {
+	pinctrl-0 = <&ether_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy0>;
+	status = "ok";
+
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen@55 {
@@ -189,6 +201,11 @@
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
+	ether_pins: ether {
+		renesas,groups = "gether_mii", "gether_int";
+		renesas,function = "gether";
+	};
+
 	scifa1_pins: serial1 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
-- 
1.7.9.5

