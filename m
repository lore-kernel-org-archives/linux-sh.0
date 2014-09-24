From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 13:20:28 +0000
Subject: [PATCH v3 9/9] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <1411564828-30272-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 51807a3..5f88108 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -211,14 +211,24 @@
 	};
 };
 
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port@1 {
+			lvds_connector: endpoint {
+			};
+		};
+	};
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
-
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
-- 
1.8.5.5

