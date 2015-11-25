From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Nov 2015 00:01:05 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: koelsch: Fix pinmux for HDMI
Message-Id: <1448409665-30811-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The signals output by the DU to the HDMI transmitter use full 24-bit
RGB. Make sure all pins are properly muxed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index da263dbb126d..bd141a54ddfc 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -326,7 +326,7 @@
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
+		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		renesas,function = "du";
 	};
 
-- 
2.4.10

