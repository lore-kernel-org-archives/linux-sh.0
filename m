From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2014 07:34:08 +0000
Subject: Re: [PATCH] shdma: add R-Car Audio DMAC peri peri driver
Message-Id: <CAMuHMdX14rktzRtV9bqHFHZV6bsmQ_k=vAZFaPeNjcJsWeX42w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu6gle8.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <878uu6gle8.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Fri, Jan 24, 2014 at 3:32 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -29,6 +29,12 @@ config RCAR_HPB_DMAE
>         help
>           Enable support for the Renesas R-Car series DMA controllers.
>
> +config RCAR_AUDMAC_PP
> +       tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"

double "Peripheral"

> +       depends on SH_DMAE_BASE
> +       help
> +         Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.

idem.

> --- /dev/null
> +++ b/drivers/dma/sh/rcar-audmapp.c
> @@ -0,0 +1,325 @@

> +static void audmapp_halt(struct shdma_chan *schan)
> +{
> +       struct audmapp_chan *auchan = to_chan(schan);
> +       int i;

unsigned int

> +
> +       audmapp_write(auchan, 0, PDMACHCR);
> +
> +       for(i = 0; i < 1024; i++) {

Missing space between "for" and "(" (have you run checkpatch.pl?)

What's a typical value of i when leaving the loop?

> +               if (0 = audmapp_read(auchan, PDMACHCR))
> +                       return;
> +               udelay(1);
> +       }
> +}
> +
> +
> +static struct audmapp_slave_config *
> +audmapp_find_slave(struct audmapp_chan *auchan, int slave_id)
> +{
> +       struct audmapp_device *audev = to_dev(auchan);
> +       struct audmapp_pdata *pdata = audev->pdata;
> +       struct audmapp_slave_config *cfg;
> +       int i;

unsigned int

> +
> +       if (slave_id >= AUDMAPP_SLAVE_NUMBER)

So slave_id should be unsigned int, too, and AUDMAPP_SLAVE_NUMBER
too ("29U").

> +               return NULL;
> +
> +       for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> +               if (cfg->slave_id = slave_id)
> +                       return cfg;
> +
> +       return NULL;
> +}

> +static int audmapp_desc_setup(struct shdma_chan *schan,
> +                             struct shdma_desc *sdecs,
> +                             dma_addr_t src, dma_addr_t dst, size_t *len)
> +{
> +       struct audmapp_chan *auchan = to_chan(schan);
> +       struct audmapp_slave_config *cfg = auchan->config;
> +
> +       if (!cfg)
> +               return -ENODEV;
> +
> +       if (*len > (size_t)AUDMAPP_LEN_MAX)

I think you can get rid of the cast by adding a "U" suffix to one of
the constants in the definition of AUDMAPP_LEN_MAX.

> +               *len = (size_t)AUDMAPP_LEN_MAX;

The cast is not needed (I think even without the change above).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
