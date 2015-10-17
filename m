From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 17 Oct 2015 06:33:08 +0000
Subject: Re: [PATCH 1/3] usb: renesas_usbhs: Remove unneeded #include <linux/platform_data/gpio-rcar.h>
Message-Id: <20151017063308.GA5508@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
 <1444206225-25664-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Oct 07, 2015 at 10:23:43AM +0200, Geert Uytterhoeven wrote:
> This header file will be removed soon.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Please schedule for v4.3, or provide an Ack, so it can go in through the
> GPIO tree. Thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
