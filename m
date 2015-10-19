From: Felipe Balbi <balbi@ti.com>
Date: Mon, 19 Oct 2015 14:21:50 +0000
Subject: Re: [PATCH 1/3] usb: renesas_usbhs: Remove unneeded #include <linux/platform_data/gpio-rcar.h>
Message-Id: <87io63j5vl.fsf@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be> <1444206225-25664-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Geert Uytterhoeven <geert+renesas@glider.be> writes:
> This header file will be removed soon.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

do you wanna take this with the other patches in the series ? I'm fine
with that:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
> Please schedule for v4.3, or provide an Ack, so it can go in through the
> GPIO tree. Thanks!
> ---
>  drivers/usb/renesas_usbhs/rcar2.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbh=
s/rcar2.c
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
> --=20
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJPyAAAoJEIaOsuA1yqREUq0P/ie/Xh89SR2C3qoLs5uzGE6c
y/tvZVKctR1gVKLlapZyhMb8iF96YhEsqL4i/zoIPrnQ3I1elQkb18VzINfAthrH
qQrQeEthf9R7d1vyBJxF3BoKunAi8eRe/lFt6GMbcDfv6CX7UMPk2GQ4uWuuraMa
GShySln2OX5G8iLOzxxCHq/oz20jWv4hXCOaTtuyDA0O3dgYvxpE1RJLH6x1fZ39
5oOSk6Lyq1Ei2vOKA5nTHDB5nqwcycxrvhAm8MRiODvfj6UcXHH4grcnNGVbYyb6
ZWvnJNj+OHrbdf35KQT6PUOp/0+wf+31isriCatjR0Yc8Vv1NaLoXz+cpoVt3IEJ
6eiCPRfjPb7pioeX7Ajl6U+WU/yAsqGInbQixw9CIecsrKnChQuCsOgpJ68gzK4W
WBI1XfYPbMi4mSmNQw4yYqCJAuriUCAS8uE4GUKwni7vtWxFW1MgGbD3C1iUQcea
RwNSoZoPsP5GwBPAzv6ZU8Fpd87s92ury9+0D3i0mQd2J9kJ8vAbwlQBVattJrio
AO2pBNax2vV5BlMH3SZg5lleKjdlU+f/a+ugpd+l2bxdekOEJjC9iAs4CHGbgXds
zBb6r77qdjFVaQ07K2DkR0P8XLh8OoMx+ieYym/lZdnboZP+tTX5vYL7DERsXTZp
+/l41TYLgppWn4cqdUAb
=/HOU
-----END PGP SIGNATURE-----
--=-=-=--
