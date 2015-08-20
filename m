From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:12 +0000
Subject: [PATCH 5/7][RFC] arm64: dts: salvatorx: add pfc node and subnodes for usb 2.0
Message-Id: <1440052154-3768-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
index 1b00390..7f6039d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
@@ -31,6 +31,23 @@
 	};
 };
 
+&pfc {
+	usb0_pins: usb0 {
+		renesas,groups = "usb0";
+		renesas,function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb2";
+	};
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
1.9.1

