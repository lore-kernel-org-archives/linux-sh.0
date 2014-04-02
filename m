From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:45 +0000
Subject: [WIP 7/7] ARM: shmobile: koelsch-reference: Add DU HDMI output support
Message-Id: <1396439205-26199-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 16 ++++++++++++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index c3b0ebe..3d313fa 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -222,6 +222,22 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	hdmi@39 {
+		compatible = "adi,adv7511";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		adi,input-id = <0>;
+		adi,input-style = <0>;
+		adi,input-color-depth = <3>;
+		adi,bit-justification = <0>;
+		adi,timing-generation-sequence = <0>;
+		adi,vsync-polarity = <0>;
+		adi,hsync-polarity = <0>;
+		adi,clock-delay = <3>;
+		adi,is-rgb;
+	};
+
 	eeprom@50 {
 		compatible = "renesas,24c02";
 		reg = <0x50>;
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 2edeb64..f124f6a 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -51,6 +51,10 @@ static struct rcar_du_encoder_data koelsch_du_encoders[] = {
 				.flags = 0,
 			},
 		},
+	}, {
+		.type = RCAR_DU_ENCODER_HDMI,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+		.of_path = "/i2c@e6530000/hdmi@39",
 	},
 };
 
-- 
1.8.3.2

