From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 12 Nov 2014 08:59:34 +0000
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys node name
Message-Id: <1415782777-4729-2-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 98504e0..d4af4d8 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -78,7 +78,7 @@
 		regulator-boot-on;
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		power-key {
-- 
2.1.1

