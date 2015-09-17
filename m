From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 08:18:58 +0000
Subject: Re: [PATCH] sh-pfc: r8a7795: add EtherAVB support
Message-Id: <CAMuHMdXXKr7qFuBKVdTJSjGaFBpKEJsDkMU8VhZHHewcjvwoiA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442471136-31894-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1442471136-31894-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Sep 17, 2015 at 8:25 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds EthernetAVB
>
> Based on a much lager patch by Takeshi Kihara which was
> originally posted by Kuninori Morimoto.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [horms: extracted from a larger patch;
>         corrected swapped {MATCH,CAPTURE_A} pins]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
