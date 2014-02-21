From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2014 16:29:16 +0000
Subject: [PATCH 2/4] spi: rspi: Remove bogus colon in formatting
Message-Id: <1393000158-6622-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1393000158-6622-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393000158-6622-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index e54924b2aff6..d57d82a74054 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -29,7 +29,7 @@ Required properties:
 - #size-cells      : Must be <0>
 
 Optional properties:
-- clocks:           : Must contain a reference to the functional clock.
+- clocks           : Must contain a reference to the functional clock.
 
 Pinctrl properties might be needed, too.  See
 Documentation/devicetree/bindings/pinctrl/renesas,*.
-- 
1.7.9.5

