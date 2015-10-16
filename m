From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 Oct 2015 15:04:36 +0000
Subject: Re: [PATCH 2/3] pinctrl: sh-pfc: Stop including <linux/platform_data/gpio-rcar.h>
Message-Id: <CACRpkdbPr6D9ZC2MbN4ybRWEUHGrf8QH8jQYUazNkZ6WNkh+yw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
	<1444206225-25664-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Oct 7, 2015 at 10:23 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> This header file will be removed soon.
>
> Copy the helper macro RCAR_GP_PIN(), which is used by the pinctrl
> drivers only, to sh_pfc.h, and drop the #include.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Include this in your pull request to me.

Yours,
Linus Walleij
