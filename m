From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Sep 2014 21:01:35 +0000
Subject: [PATCH v4 2/2] ARM: shmobile: lager: enable USB PHY
Message-Id: <1862889.19pI7tAsvN@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4420279.PiYV5HPFxp@wasted.cogentembedded.com>
In-Reply-To: <4420279.PiYV5HPFxp@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable USB PHY device for the Lager board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- refreshed the patch.

Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7790-lager.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -424,6 +424,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 /* composite video input */
 &vin1 {
 	pinctrl-0 = <&vin1_pins>;

