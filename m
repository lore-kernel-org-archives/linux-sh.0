From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 16 Feb 2015 16:58:53 +0000
Subject: [PATCH v3 09/15] ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
Message-Id: <1424105939-4910-10-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds pin control info for USB host and video-in devices.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 280a922..7d9ab9a 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -123,6 +123,26 @@
 		renesas,groups = "hspi0_a";
 		renesas,function = "hspi0";
 	};
+
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
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
+
+	vin1_pins: vin1 {
+		renesas,groups = "vin1_data8", "vin1_clk";
+		renesas,function = "vin1";
+	};
 };
 
 &sdhi0 {
-- 
2.2.2

