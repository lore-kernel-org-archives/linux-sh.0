From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Aug 2015 15:00:21 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7778: enable IRLM setup via DT
Message-Id: <20150817150020.GA12227@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1439560388-5061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1439560388-5061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 17, 2015 at 11:44:24AM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 14, 2015 at 3:53 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > Works the same as on r8a7779.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks Ulrich,

I'm very happy to see this series.

> > ---
> >  arch/arm/boot/dts/r8a7778.dtsi            | 3 ++-
> >  drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++++--
> 
> I think this should be split in two separate patches.

Agreed.

The .dtsi portion is a DT patch that should go through the ARM SoC tree
via my tree.

The .c portion is a driver change that should probably
be handled by Jason Cooper.

Ulrich, please let me know if you need any help moving this forwards.

> For both, you can add my
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
