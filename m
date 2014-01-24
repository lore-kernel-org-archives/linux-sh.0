From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 24 Jan 2014 08:18:38 +0000
Subject: Re: [PATCH] shdma: add R-Car Audio DMAC peri peri driver
Message-Id: <871tzxg5d1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu6gle8.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdX14rktzRtV9bqHFHZV6bsmQ_k=vAZFaPeNjcJsWeX42w@mail.gmail.com>
In-Reply-To: <CAMuHMdX14rktzRtV9bqHFHZV6bsmQ_k=vAZFaPeNjcJsWeX42w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi Geert

Thank you for your review

> > --- a/drivers/dma/sh/Kconfig
> > +++ b/drivers/dma/sh/Kconfig
> > @@ -29,6 +29,12 @@ config RCAR_HPB_DMAE
> >         help
> >           Enable support for the Renesas R-Car series DMA controllers.
> >
> > +config RCAR_AUDMAC_PP
> > +       tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"
> 
> double "Peripheral"

Unfortunately (?) "Audio DMAC Peripheral Peripheral"
(= double Peripheral) is the formal name

> > +       for(i = 0; i < 1024; i++) {
> 
> Missing space between "for" and "(" (have you run checkpatch.pl?)
> 
> What's a typical value of i when leaving the loop?

Oops, this is my fault.
I will fix in v2

> > +static struct audmapp_slave_config *
> > +audmapp_find_slave(struct audmapp_chan *auchan, int slave_id)
> > +{
> > +       struct audmapp_device *audev = to_dev(auchan);
> > +       struct audmapp_pdata *pdata = audev->pdata;
> > +       struct audmapp_slave_config *cfg;
> > +       int i;
> 
> unsigned int
> 
> > +
> > +       if (slave_id >= AUDMAPP_SLAVE_NUMBER)
> 
> So slave_id should be unsigned int, too, and AUDMAPP_SLAVE_NUMBER
> too ("29U").

Hmm...
This driver is called from shdma-base.c.
And shdmac.c/sudmac.c/rcar-hpbdmac.c are same style.

 1) this "slave_id" came from shdma_ops::set_slave
    and, it is using "int"
 2) above drivers have same xxx_find_slave(),
    they are using "int".
    (this driver is based on that)

What should I do ?

> > +       if (*len > (size_t)AUDMAPP_LEN_MAX)
> 
> I think you can get rid of the cast by adding a "U" suffix to one of
> the constants in the definition of AUDMAPP_LEN_MAX.
> 
> > +               *len = (size_t)AUDMAPP_LEN_MAX;
> 
> The cast is not needed (I think even without the change above).

I will fixup these in v2
Thank you


Best regards
---
Kuninori Morimoto
