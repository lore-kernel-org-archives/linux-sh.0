From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 01 Sep 2014 16:40:50 +0000
Subject: Re: [PATCH v2] usb: renesas_usbhs: fix driver dependencies
Message-Id: <CAMuHMdVp16nXS1GefyV0OD7Dwewct0UPTEEYLj+GKCrnBxjhLw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1601192.oClrOJlUe8@amdc1032>
In-Reply-To: <1601192.oClrOJlUe8@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Sep 1, 2014 at 4:24 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Renesas USBHS controller support should be available only on
> Renesas ARM SoCs and SuperH architecture.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
> v2:
> - s/ARCH_SH/SUPERH/ (thanks to Sergei Shtylyov)

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
