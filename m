From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2020 13:46:39 +0000
Subject: Re: [PATCH 00/13] pinctrl: sh-pfc: checker: Various improvements
Message-Id: <CAMuHMdVCwkwobX=LTx3Oz6Jq3orZ9j6VjdfbZTXAREZTWM3Mgw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be> <20200110202950.GA695049@oden.dyn.berto.se>
In-Reply-To: <20200110202950.GA695049@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Jan 10, 2020 at 9:29 PM Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> Neat series. I always worry when my eyes start to cross each other when
> looking at the big tables I will make mistakes like this ;-)
>
> On 2020-01-10 14:19:14 +0100, Geert Uytterhoeven wrote:
> > This patch series contains various improvements for the builtin pin
> > control table runtime checks of the Renesas Pin Function Controller
> > driver.  These checks are enabled with CONFIG_DEBUG_PINCTRL=y, which can
> > be combined with CONFIG_COMPILE_TEST=y to increase coverage to all
> > Renesas ARM and SuperH SoCs..
> >
> > Note that all issues detected by this have already been fixed in "[PATCH
> > 0/6] pinctrl: sh-pfc: More miscellenaous fixes"[1], and are now part of
> > linux-next.
> >
> > I plan to queue this in sh-pfc-for-v5.7.
>
> With the fix you point out yourself in 13/13 for
> CONFIG_PINCTRL_SH_FUNC_GPIO=n feel free to add
>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>
> For the whole series.

Thanks, queue in sh-pfc-for-v5.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
