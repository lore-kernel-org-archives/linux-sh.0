From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 12 Nov 2014 08:59:35 +0000
Subject: [PATCH 2/4] ARM: shmobile: lager: Use keyboard as gpio-keys node name
Message-Id: <1415782777-4729-3-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 2f91740..814bde2 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -62,7 +62,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio_keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		button@1 {
-- 
2.1.1

