From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Apr 2014 22:24:55 +0000
Subject: [PATCH 2/2] ARM: shmobile: koelsch: enable USB PHY
Message-Id: <201404090224.56114.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404090221.53167.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404090221.53167.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable USB PHY device for the Lager board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -409,3 +409,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
