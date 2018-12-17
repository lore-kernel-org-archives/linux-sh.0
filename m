From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 15:17:24 +0000
Subject: Re: [PATCH 11/15] pinctrl: sh-pfc: Print actual field width for variable-width fields
Message-Id: <20181217151721.yfoplcb4hi2gelgr@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-12-geert+renesas@glider.be>
 <20181217144618.a6omxq2y4acydp75@verge.net.au>
 <CAMuHMdV6rTRGDjuExaDNjSdBrVg3hb=kZB8RsqibZYKZm6HSsQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV6rTRGDjuExaDNjSdBrVg3hb=kZB8RsqibZYKZm6HSsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>

On Mon, Dec 17, 2018 at 03:58:52PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 17, 2018 at 3:46 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Dec 13, 2018 at 07:27:10PM +0100, Geert Uytterhoeven wrote:
> > > The debug code in sh_pfc_write_config_reg() prints the width of the
> > > field being modified.
> > >
> > > However, registers with a variable-width field layout are identified by
> > > pinmux_cfg_reg.field_width being zero, hence zeroes are printed instead
> > > of the actual field widths.
> > >
> > > Fix this by printing the Hamming height of the field mask instead, which
> > > is correct for both fixed-width and variable-width fields.
> >
> > s/height/width ?
> 
> Nah, weight. Will fix.
> https://en.wikipedia.org/wiki/Hamming_weight

I was thinking weight :)

> 
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
