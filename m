From: phil.edworthy@renesas.com
Date: Wed, 06 Mar 2013 07:18:39 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <OF940767FB.059ECAFD-ON80257B26.0027491F-80257B26.00282223@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon & Morimoto-san,

> > > >  static struct pinmux_data_reg pinmux_data_regs[] = {
> > > > -   { PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
> > > > -   { PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
> > > > -   { PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
> > > > -   { PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
> > > > -   { PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
> > > > -   { PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
> > > > -   { PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
> > > > +   { PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
> > > > +   { PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
> > > > +   { PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
> > > > +   { PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
> > > > +   { PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
> > > > +   { PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
> > > > +   { PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
> > > >        0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
> > > >        0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
> > > >        GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
> > > 
> > > Hmm, this isn't what you want. I sent a similar patch on this a 
> while back 
> > > before realising that the problem is that the pfc driver doesn't 
support 
> > > separate input and output data registers, only one reg for both 
input and 
> > > output. With the code as it is, the gpio pins act as outputs. 
> Changing the 
> > > addresses as per this patch means the gpios act now as inputs.
> > 
> > This patch ?
> > [sh: pfc: Add ability to use separate read & write GPIO data regs]
Yes, this is the patch I was referring to,

> > I need more information about this, because my previous R-Car M1 GPIO 
is
> > using INPUT address like above
> > 
> >  - Is your patch (above patch ?) applied to Simon's branch ?
> 
> No, it is not in my tree.
> I would be happy to add it if Laurent is happy with it.
> Or for him to include it in his forthcoming pinctrl patch set(s).
Paul gave the patch a quick review & pointed out that I really needed to 
use clearer nomenclature. He also suggested that it might be better to use 
a single mapping for both INDT and OUTDT registers in the pfc driver. 
Whilst the latter is easy enough to fix if the order of INDT and OUTDT are 
always the same, I don't know if this is the case for all/upcoming 
devices.

Anyhow, I don't think that Morimoto-san's "sh-pfc: r8a7779: fixup INDTx 
address" patch should be used as it changes the functionality (not what it 
says in the description) and doesn't fix the underlying issue.

Thanks
Phil
