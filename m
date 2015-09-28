From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 28 Sep 2015 13:28:03 +0000
Subject: [PATCH] spi: sh-msiof: Match renesas,rx-fifo-size in DT bindings doc with driver
Message-Id: <1443446883-4189-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Koji Matsuoka <koji.matsuoka.xm-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Commit fe78d0b7691c0274 ("spi: sh-msiof: Fix FIFO size to 64 word from
256 word") changed the default RX FIFO size on R-Car Gen2 SoCs in the
driver code, but forgot to update the DT bindings documentation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 8f771441be60556a..705075da2f10156e 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -51,7 +51,7 @@ Optional properties, deprecated for soctype-specific bindings:
 - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
 			 (default is 64)
 - renesas,rx-fifo-size : Overrides the default rx fifo size given in words
-			 (default is 64, or 256 on R-Car Gen2)
+			 (default is 64)
 
 Pinctrl properties might be needed, too.  See
 Documentation/devicetree/bindings/pinctrl/renesas,*.
-- 
1.9.1

