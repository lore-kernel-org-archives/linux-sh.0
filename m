From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:42 +0000
Subject: [RFC/PATCH 7/7] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <1390318362-29954-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

Enable the DU device and configure the related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74f0985..678c54e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -104,6 +104,12 @@
 	};
 };
 
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
@@ -112,6 +118,11 @@
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
-- 
1.8.3.2

