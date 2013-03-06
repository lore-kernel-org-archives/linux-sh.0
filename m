From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 00:51:28 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <87k3pll59u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Phil

Thank you for your reply

> >  static struct pinmux_data_reg pinmux_data_regs[] = {
> > -   { PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
> > -   { PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
> > -   { PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
> > -   { PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
> > -   { PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
> > -   { PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
> > -   { PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
> > +   { PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
> > +   { PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
> > +   { PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
> > +   { PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
> > +   { PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
> > +   { PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
> > +   { PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
> >        0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
> >        0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
> >        GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
> 
> Hmm, this isn't what you want. I sent a similar patch on this a while back 
> before realising that the problem is that the pfc driver doesn't support 
> separate input and output data registers, only one reg for both input and 
> output. With the code as it is, the gpio pins act as outputs. Changing the 
> addresses as per this patch means the gpios act now as inputs.

This patch ?
[sh: pfc: Add ability to use separate read & write GPIO data regs]

I need more information about this, because my previous R-Car M1 GPIO is
using INPUT address like above

 - Is your patch (above patch ?) applied to Simon's branch ?
 - Is some SoC (= H1 ?) using it ?

I need sample code

Best regards
---
Kuninori Morimoto
