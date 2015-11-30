From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Nov 2015 00:38:30 +0000
Subject: Re: [PATCH 06/18] arm64: renesas: r8a7795: add I2C support
Message-Id: <20151130003829.GC3501@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
 <32bc0c51be7c9db3762cbb34af465676c769886b.1448587800.git.horms+renesas@verge.net.au>
 <CAMuHMdU0eKSe9_sRnw8nxuMPz8i0B0vLQzBDbOxTQ9Nb85M9jg@mail.gmail.com>
In-Reply-To: <CAMuHMdU0eKSe9_sRnw8nxuMPz8i0B0vLQzBDbOxTQ9Nb85M9jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 27, 2015 at 09:17:07AM +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 27, 2015 at 2:55 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > [geert: aAdd clock-output-names properties]
> 
> That part is no longer true.

Oops. I'll drop that if there is a need to repost this pull-request.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
