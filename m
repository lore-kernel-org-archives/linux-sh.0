From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 Sep 2015 00:11:43 +0000
Subject: Re: [PATCH] [RFC] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <87bnckg47l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443017673-12311-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443017673-12311-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso@kth.se>, Koji Matsuoka <koji.matsuoka.xm@rms.renesas.com>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org


Hi Geert

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Please review and comment!
> 
>   - I still have a hard time understanding the subtilties of the various
>     PINMUX_IPSR_*() macros,
>   - Which macro is most appropriate for describing single-function pins:
>     PINMUX_DATA() or PINMUX_IPSR_NOGP()?
>     (cfr. "[RFC] pinctrl: sh-pfc: r8a7795: Add pinmux data for
>      single-function pins",
>      http://www.spinics.net/lists/linux-sh/msg44823.html

I don't care about this, but my point was that I don't like
directly using xxx_MARK in pinmux_data[] (it looks like different style).
And it already had PINMUX_IPSR_NOGP() list in end of pinmux_data[]

> +/*
> + * Describe a pinmux configuration without GPIO function that needs
> + * configuration in a Peripheral Function Select Register (IPSR)
> + *   - ipsr: IPSR field (unused, for documentation purposes only)
> + *   - fn: Function name
> + */
>  #define PINMUX_IPSR_NOGP(ispr, fn)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn)
(snip)
> +/*
> + * Describe a pinmux configuration where ???
> + *   - ipsr: IPSR field
> + *   - fn: Function name
> + *   - ms: Configuration register selector
> + */
>  #define PINMUX_IPSR_NOGM(ispr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)

I forgot detail, but this NOGM = NOGP + MSEL
It doesn't need GP settings, but need SEL_xxx
