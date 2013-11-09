From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:23:58 +0000
Subject: [PATCH 6/7] ARM: shmobile: kzm9g-reference: Use falling edge IRQ for LAN9221
Message-Id: <1383999839-3339-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Configure the IRQ to trigger on falling edge.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 605f6c6..12fdfaa 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -83,7 +83,7 @@
 		reg = <0x10000000 0x100>;
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
-		interrupts = <3 IRQ_TYPE_NONE>;	/* active low */
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 		reg-io-width = <4>;
 		smsc,irq-push-pull;
 		smsc,save-mac-address;
-- 
1.8.1.5

