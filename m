From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 14 Oct 2015 19:35:46 +0000
Subject: [PATCH] ARM: shmobile: porter: add HS-USB DT support
Message-Id: <80272771.MSjafmr6yE@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable HS-USB device  for the Porter board, defining the GPIO that the
driver should check  when probing (which is the ID output from MAX3355
OTG chip).

Note that there  will be pinctrl-related error messages if both internal
PCI  and  HS-USB drivers are enabled but they should be just ignored.

This patch is  analogous  to the commit 6f4f7156e0e6 (ARM: shmobile:
henninger: enable HS-USB) as there  are no differences between the
boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151013v2-v4.3-rc5' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -269,6 +269,14 @@
 	status = "okay";
 };
 
+&hsusb {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };

