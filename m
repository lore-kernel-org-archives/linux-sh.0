From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Oct 2015 10:58:05 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Rename .gpio_data[] to .pinmux_data[]
Message-Id: <CACRpkdYL575BdfuQgkBv_XVP8a1CKAUBQU1r=Jt4tx7NDpDkHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443016754-24203-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443016754-24203-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Sep 23, 2015 at 6:59 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The sh_pfc_soc_info.gpio_data[] array contains not only GPIO data, but
> also various other pinmux-related data (functions and marks).
> Every single driver already calls its local array pinmux_data[].
> Hence rename the sh_pfc_soc_info member to "pinmux_data".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
