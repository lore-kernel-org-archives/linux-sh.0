From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Feb 2020 13:32:35 +0000
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Message-Id: <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
In-Reply-To: <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Peter,

On Mon, Feb 3, 2020 at 1:49 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/02/2020 13.16, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 12:59 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 03/02/2020 12.37, Andy Shevchenko wrote:
> >>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>>> Advise users of dma_request_slave_channel() and
> >>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >>>
> >>> How? There are legacy ARM boards you have to care / remove before.
> >>> DMAengine subsystem makes a p*s off decisions
> >>
> >> The dma_slave_map support is added few years back for the legacy ARM
> >> boards, because we do care.
> >> daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.
> >
> > Then why simple not to convert (start converting) those few drivers to
> > new API and simple remove the old one?
>
> _if_ the dma_request_slave_channel_compat() is really falling back after
> dma_request_chan() - this is what it calls first, then it is not a
> simple convert to a new API.
> 1. The arch needs to define the dma_slave_map for the SoC.
> 2. The dma driver needs few lines to add it to DMAengine core (+pdata
> change).
> After this the _compat() can be replaced with dma_request_chan()
>
> In most cases I do not have access to documentation and boards to test.
>
> Looking at the output of 'git grep dma_request_slave_channel_compat':
> drivers/mmc/host/renesas_sdhi_sys_dmac.c
> drivers/spi/spi-pxa2xx-dma.c
> drivers/spi/spi-rspi.c
> drivers/spi/spi-sh-msiof.c
> drivers/tty/serial/8250/8250_dma.c
>
> From these rspi boots only in DT and I'm not sure about the others.

Both rspi and sh-msiof have users on legacy SH (i.e. without DT):

    arch/sh/kernel/cpu/sh4a/setup-sh7757.c: .name   = "rspi",
    arch/sh/boards/mach-ecovec24/setup.c:   .name           = "spi_sh_msiof",

The former seems to be used with drivers/dma/sh/shdmac.c:

    arch/sh/include/cpu-sh4/cpu/sh7757.h:   SHDMA_SLAVE_RSPI_TX,
    arch/sh/include/cpu-sh4/cpu/sh7757.h:   SHDMA_SLAVE_RSPI_RX,
    arch/sh/kernel/cpu/sh4a/setup-sh7757.c:         .slave_id       SHDMA_SLAVE_RSPI_TX,
    arch/sh/kernel/cpu/sh4a/setup-sh7757.c:         .slave_id       SHDMA_SLAVE_RSPI_RX,

but I have no idea if it still works (and no hardware).

The latter doesn't seem to be used with DMA on ecovec24/sh7724, so
probably we can just drop the _compat() from sh-sh-msiof.c.

BTW, we no longer support non-legacy DMA in drivers/tty/serial/sh-sci.c
(DMA was completely broken in that driver when I added DT suppport),
but it seems it was used at some point on various SH, cfr. e.g.
arch/sh/kernel/cpu/sh4a/setup-sh7724.c still setting up the channels.
Which might be a motivation for just dropping _compat() from spi-rspi.c,
too? ;-)

Anyone who cares for DMA on SuperH?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
