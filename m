From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 01 Oct 2015 22:06:23 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: silk: enable USB PHY
Message-Id: <1759135.UUeR1nn4JC@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4938706.NQELE8A71r@wasted.cogentembedded.com>
In-Reply-To: <4938706.NQELE8A71r@wasted.cogentembedded.com>
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

