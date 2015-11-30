From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 14:14:00 +0000
Subject: [PATCH] spi: sh-msiof: Add support for SH-Mobile AG5
Message-Id: <1448892840-8195-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

MSIOF in SH-Mobile AG5 (sh73a0) is handled fine by the existing driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 705075da2f10156e..aa005c1d10d95756 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -10,6 +10,7 @@ Required properties:
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
+			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
-- 
1.9.1

