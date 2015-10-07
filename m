From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 08:23:43 +0000
Subject: [PATCH 1/3] usb: renesas_usbhs: Remove unneeded #include <linux/platform_data/gpio-rcar.h>
Message-Id: <1444206225-25664-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

This header file will be removed soon.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Please schedule for v4.3, or provide an Ack, so it can go in through the
GPIO tree. Thanks!
---
 drivers/usb/renesas_usbhs/rcar2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
index 8fc15c0ba339..277160bc6f25 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -13,7 +13,6 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
-#include <linux/platform_data/gpio-rcar.h>
 #include <linux/usb/phy.h>
 #include "common.h"
 #include "rcar2.h"
-- 
1.9.1

