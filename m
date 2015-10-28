From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Oct 2015 09:33:30 +0000
Subject: Re: [PATCH v4 1/3] arm64: renesas: r8a7795: add I2C support
Message-Id: <CAMuHMdWKrr=s5BZb=5VsHunAeOVo8xc-jDicW+XaWF3=Mmvz3w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
 <1445987129-13496-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1445987129-13496-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 28, 2015 at 12:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [geert: aAdd clock-output-names properties]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

As the clock-output-names are no longer valid, please replace the
above two lines by

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
