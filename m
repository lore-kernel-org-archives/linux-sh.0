From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Jun 2015 01:05:40 +0000
Subject: Re: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <20150617010539.GC5143@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 15, 2015 at 10:44:33AM +0200, Geert Uytterhoeven wrote:
> Hi Morimoto-san,
> 
> On Mon, Jun 15, 2015 at 10:30 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >> > +       gic: interrupt-controller@0xf1010000 {
> >> > +               compatible = "arm,gic-400", "arm,cortex-a15-gic";
> >> > +               #interrupt-cells = <3>;
> >> > +               #address-cells = <0>;
> >> > +               interrupt-controller;
> >> > +               reg = <0x0 0xf1010000 0 0x1000>,
> >> > +                     <0x0 0xf1020000 0 0x2000>;
> >> > +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> >> > +       };
> >>
> >> Thanks for your efforts. On ARM v8, is ARM v7 compat string
> >> "arm,cortex-a15-gic" really correct?
> >
> > I don't know detail of this.
> > but, I guess current Inami-san's status is "create working something".
> > Maybe he don't care small detail at this point.
> > Do you think  "arm,gic-400" is very enough ?
> > If so, I can drop it in v2
> 
> Both are (currently) handled identically by drivers/irqchip/irq-gic.c.
> 
> As the datasheet documents it as "GIC-400", we should use "arm,gic-400".
> BTW, we should do the same for APE6 and R-Car Gen2, cfr.
> https://lkml.org/lkml/2015/4/29/315

Although it seems low priority I am interested in cleaning up the GIC nodes
for the you mention above. Can I confirm that their desired compat string
usage is:

	compatible = "arm,gic-400";
