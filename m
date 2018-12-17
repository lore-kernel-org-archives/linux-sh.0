From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 19:58:57 +0000
Subject: Re: [PATCH 06/15] pinctrl: sh-pfc: r8a77995: Remove bogus SEL_PWM[0-3]_3 configurations
Message-Id: <20181217195857.vaxxsfm4uwyfs6zi@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-7-geert+renesas@glider.be>
 <20181217140723.l76nsznmu7exzqha@verge.net.au>
 <CAMuHMdUjvVUd52hco_kmNVs2hscfr4vXhd1rZvSegGz7kTYCTg@mail.gmail.com>
In-Reply-To: <CAMuHMdUjvVUd52hco_kmNVs2hscfr4vXhd1rZvSegGz7kTYCTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>

On Mon, Dec 17, 2018 at 03:12:27PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 17, 2018 at 3:07 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Dec 13, 2018 at 07:27:05PM +0100, Geert Uytterhoeven wrote:
> > > While the SEL_PWM[0-3] fields in the Module Select Register 0 support 4
> >
> > s/support/supports
> 
> "fields" is plural, hence "support".

Yes, I see that now. Sorry for the noise.

> > > possible configurations per PWM pin, only the first 3 are valid.
> > >
> > > Replace the invalid and unused configurations for SEL_PWM[0-3]_3 by
> > > dummies.
> > >
> > > Fixes: 794a6711764658a1 ("pinctrl: sh-pfc: Initial R8A77995 PFC support")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks!
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
