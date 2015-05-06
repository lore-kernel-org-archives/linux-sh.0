From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 May 2015 04:05:31 +0000
Subject: [PATCH] ARM: shmobile: lager: Fix adv7511 IRQ sensing
Message-Id: <1430885131-6098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The adv7511 IRQ is low level triggered, not falling edge triggered. The
wrong sense configuration results in no interrupt being triggered at
all, breaking hotplug detection. Fix it.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Ben, would you be able to test this ? I won't have access to my Lager board
before Sunday.

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 46f4c56c287c..21782e6b37f7 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -548,7 +548,7 @@
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
Regards,

Laurent Pinchart

