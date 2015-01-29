From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Jan 2015 00:35:43 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150129003543.GE18731@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150128124645.21199.99590.sendpatchset@little-apple>
In-Reply-To: <20150128124645.21199.99590.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 28, 2015 at 02:34:43PM +0100, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Wed, Jan 28, 2015 at 1:46 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > domain."), the APE6EVM legacy board support is known to be broken.
> >
> > The IRQ numbers of the GIC are now virtual, and no longer match the
> > hardcoded hardware IRQ numbers in the legacy platform board code.
> >
> > To fix this issue specific to non-muliplatform r8a73a4 and APE6EVM:
> >  1) Instantiate the GIC from platform board code and also
> >  2) Skip over the DT arch timer as well as
> >  3) Force delay setup based on DT CPU frequency
> >
> > With these 3 fixes in place interrupts on APE6EVM are now unbroken.
> >
> > Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
> > him for the initial work.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Thanks!
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up as a fix for v3.19.

> BTW, has anything tested lager-legacy with v3.19-rcX?
> We forgot about it as its removal is queued, but it's probably affected, too
> (.init_irq is not set, and board-lager.c uses irq numbers in platform devices).
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
