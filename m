From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Oct 2015 10:33:00 +0000
Subject: RE: [PATCH 1/3] usb: renesas_usbhs: Remove unneeded #include <linux/platform_data/gpio-rcar.h>
Message-Id: <SG2PR06MB09192CB02C88F3D53E3F75AFD8360@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
 <1444206225-25664-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

Hi Geert-san,

> Sent: Wednesday, October 07, 2015 5:24 PM
> 
> This header file will be removed soon.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Please schedule for v4.3, or provide an Ack, so it can go in through the
> GPIO tree. Thanks!
> ---

I'm not sure my Acked-by is useful for it :)
Anyway,

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

>  drivers/usb/renesas_usbhs/rcar2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
> index 8fc15c0ba339..277160bc6f25 100644
> --- a/drivers/usb/renesas_usbhs/rcar2.c
> +++ b/drivers/usb/renesas_usbhs/rcar2.c
> @@ -13,7 +13,6 @@
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
> -#include <linux/platform_data/gpio-rcar.h>
>  #include <linux/usb/phy.h>
>  #include "common.h"
>  #include "rcar2.h"
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
