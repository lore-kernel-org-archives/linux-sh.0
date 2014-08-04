From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 07:53:30 +0000
Subject: Re: [PATCH 3/3] dma: rcar-audmapp: add DT support
Message-Id: <CAMuHMdUY5rHrvwDp6RpHoY3vmGc9Khi-jkkiTytby6CxZgmauA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppi6y4n2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppi6y4n2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Jul 15, 2014 at 12:51 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
> @@ -0,0 +1,29 @@

> +Required properties:
> +- dmas:                a list of <[DMA multiplexer phandle] [SRS/DRS value]> pairs,
> +               where SRS/DRS values are fixed handles, specified in the SoC
> +               manual as the value that would be written into the PDMACHCR.

I think this wording is a little bit confusing.
It's not the "value that would be written into the PDMACHCR", but the
high 16-bit
part of that value, cfr. the example and the actual code below.

An alternative way of saying this could be "SRS << 8 | DRS", which clearly
shows how to combine SRS and DRS.
Unlike the docs for SYS-DMAC, which contains a table of combined MID/RID
values,  the Audio DMAC-peri-peri docs contain 2 separate tables for SRS and
DRS values, so the DTS writer has to combine them manually.

> +- dma-names:   a list of DMA channel names, one per "dmas" entry
> +
> +Example:
> +
> +       dmas = <&audmapp 0x2d00
> +               &audmapp 0x3700>;
> +       dma-names =  "src0_ssiu0",
> +                    "dvc0_ssiu0";

> --- a/drivers/dma/sh/rcar-audmapp.c
> +++ b/drivers/dma/sh/rcar-audmapp.c

> @@ -114,38 +117,50 @@ static void audmapp_start_xfer(struct shdma_chan *schan,
>         audmapp_write(auchan, chcr,     PDMACHCR);
>  }
>
> -static struct audmapp_slave_config *
> -audmapp_find_slave(struct audmapp_chan *auchan, int slave_id)
> +static void audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
> +                             u32 *chcr, dma_addr_t *dst)
>  {

> +       if (!pdata) { /* DT */
> +               *chcr = ((u32)slave_id) << 16;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
