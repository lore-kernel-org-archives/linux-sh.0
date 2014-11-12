From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 12 Nov 2014 08:59:36 +0000
Subject: [PATCH 3/4] ARM: shmobile: koelsch: Use keyboard as gpio-keys node name
Message-Id: <1415782777-4729-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This appears to be the best match for ePAPR.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0551f13..732de56 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -63,7 +63,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		key-1 {
-- 
2.1.1

