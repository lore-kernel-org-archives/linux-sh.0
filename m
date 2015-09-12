From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 12 Sep 2015 22:53:32 +0000
Subject: [PATCH 2/2] ARM: shmobile: silk: enable USB PHY
Message-Id: <3084035.cKzzM7V4Ux@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
In-Reply-To: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable USB PHY device for the SILK board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -210,3 +210,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};

