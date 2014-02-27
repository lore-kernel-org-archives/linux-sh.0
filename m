From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Feb 2014 12:47:17 +0000
Subject: [PATCH] spi: sh-msiof: Remove "renesas,msiof-sh7724" from bindings
Message-Id: <1393505238-11954-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

It's not implemented in the driver, so it's a bad example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt |    1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 1f0cb33763a1..f24baf3b6cc1 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -5,7 +5,6 @@ Required properties:
 			 "renesas,sh-msiof" for SuperH, or
 			 "renesas,sh-mobile-msiof" for SH Mobile series.
 			 Examples with soctypes are:
-			 "renesas,msiof-sh7724" (SH)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2)
 - reg                  : Offset and length of the register set for the device
-- 
1.7.9.5

