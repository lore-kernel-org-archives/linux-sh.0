From: Simon Horman <horms@verge.net.au>
Date: Sat, 27 Nov 2010 21:17:36 +0000
Subject: Re: [PATCH 3/3 v2] sh, mmc: Use defines when setting CE_CLK_CTRL
Message-Id: <20101127211736.GC2090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au>
 <1290812579-20410-3-git-send-email-horms@verge.net.au>
 <20101127000109.GA29427@verge.net.au>
 <20101127001155.GA30946@verge.net.au>
 <AANLkTi=zKbNhVz=Bh7ytRezobsnxeWE49mJcAS=rJ4Oq@mail.gmail.com>
In-Reply-To: <AANLkTi=zKbNhVz=Bh7ytRezobsnxeWE49mJcAS=rJ4Oq@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

On Sat, Nov 27, 2010 at 12:54:41PM +0100, Michał Mirosław wrote:
> 2010/11/27 Simon Horman <horms@verge.net.au>:
> > The 16-19th bits of CE_CLK_CTRL set the
> > MMC clock frequency.
> >
> > Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  include/linux/mmc/sh_mmcif.h |   17 +++++++++--------
> >  1 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
> > index 519a2cd..44fc534 100644
> > --- a/include/linux/mmc/sh_mmcif.h
> > +++ b/include/linux/mmc/sh_mmcif.h
> > @@ -77,6 +77,9 @@ struct sh_mmcif_plat_data {
> >  #define CLK_ENABLE             (1 << 24) /* 1: output mmc clock */
> >  #define CLK_CLEAR              ((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
> >  #define CLK_SUP_PCLK           ((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
> > +#define CLKDIV_4               (1<<16) /* mmc clock frequency.
> > +                                        * n: bus clock/(2^(n+1)) */
> > +#define CLKDIV_256             (7<<16) /* mmc clock frequency. (see above) */
> >  #define SRSPTO_256             ((1 << 13) | (0 << 12)) /* resp timeout */
> >  #define SRBSYTO_29             ((1 << 11) | (1 << 10) |        \
> >                                 (1 << 9) | (1 << 8)) /* resp busy timeout */
> [...]
> 
> Maybe zero is a valid value here meaning CLKDIV = 2.

Hi Michał,

Yes, it is. I intended to provide defines only for values that are used.
But I can provide all the valid values (there are only 9) it that
makes thing clearer. Or perhaps change the comment to:

					    /* CLKDIV_n
					     * mmc clock frequency.
					     * n: bus clock/(2^(m+1))
					     *    where 0 <= m <= 8 */

