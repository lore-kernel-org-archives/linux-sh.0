From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:58:07 +0000
Subject: [PATCH 07/16] ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
Message-Id: <1898fe1952c2aeb847c4aa5b897605373f0498cf.1425518337.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds pin control info for USB host and video-in devices.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 7347223..96cfcdc 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -98,6 +98,26 @@
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
2.1.4

