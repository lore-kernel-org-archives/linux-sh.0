From: Simon Horman <horms@verge.net.au>
Date: Fri, 15 Jan 2016 12:14:10 +0000
Subject: Re: [PATCH v3 14/14] ARM: shmobile: r8a7793: enable audio DMAC in device tree
Message-Id: <20160115121405.GA4005@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
 <1452825487-15931-15-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXHixAuiYayxmvOLLm39w4iTosVucRtN7ASuHGuY7p5-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXHixAuiYayxmvOLLm39w4iTosVucRtN7ASuHGuY7p5-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 15, 2016 at 11:45:35AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jan 15, 2016 at 3:38 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -1201,52 +1201,119 @@
> >                 status = "disabled";
> >
> >                 rcar_sound,dvc {
> > -                       dvc0: dvc@0 { };
> > -                       dvc1: dvc@1 { };
> > +                       dvc0: dvc@0 {
> > +                               dmas = <&audma0 0xbc>;
> > +                               dma-names = "tx";
> > +                       };
> > +                       dvc1: dvc@1 {
> > +                               dmas = <&audma0 0xbe>;
> > +                               dma-names = "tx";
> > +                       };
> >                 };
> > +
> >                 rcar_sound,src {
> > -                       src0: src@0 { };
> > -                       src1: src@1 { };
> > -                       src2: src@2 { };
> > -                       src3: src@3 { };
> > -                       src4: src@4 { };
> > -                       src5: src@5 { };
> > -                       src6: src@6 { };
> > -                       src7: src@7 { };
> > -                       src8: src@8 { };
> > -                       src9: src@9 { };
> > +                       src0: src@0 {
> > +                               interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
> 
> <GIC_SPI ...> (and more below)
> 
> >                 rcar_sound,ssi {
> >                         ssi0: ssi@0 {
> >                                 interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
> 
> <GIC_SPI ...>
> 
> Ah, you already let a few pass through before ;-)

Thanks, I'll fix this up.

> > +                               dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
> > +                               dma-names = "rx", "tx", "rxu", "txu";
> >                         };
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
