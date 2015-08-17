From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 14:03:52 +0000
Subject: Re: Issues with rcar-dmac and sh-sci
Message-Id: <CAMuHMdUQ+za1cZqzP1MyAKYt6M3BO_Wfn83bwUAdgBh7Hm1AJQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sat, Aug 15, 2015 at 1:42 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> From 131968befd5de3400631b879b1574beea27b8239 Mon Sep 17 00:00:00 2001
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date: Sat, 15 Aug 2015 01:28:28 +0300
> Subject: [PATCH] dmaengine: rcar-dmac: Fix residue reporting for pending
>  descriptors
>
> Cookies corresponding to pending transfers have a residue value equal to
> the full size of the corresponding descriptor. The driver miscomputes
> that and uses the size of the active descriptor instead. Fix it.

Thanks!

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07e7bee..a98596a1f12f 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1143,19 +1143,43 @@ static unsigned int rcar_dmac_chan_get_residue(struct
> rcar_dmac_chan *chan,
>         struct rcar_dmac_desc *desc = chan->desc.running;
>         struct rcar_dmac_xfer_chunk *running = NULL;
>         struct rcar_dmac_xfer_chunk *chunk;
> +       enum dma_status status;
>         unsigned int residue = 0;
>         unsigned int dptr = 0;
>
>         if (!desc)
>                 return 0;
>
> +
> +       /*
> +        * If the cookie corresponds to a descriptor that has been completed
> +        * there is no residue. The same check has already been performed by the
> +        * caller but without holding the channel lock, so the descriptor could
> +        * now be complete.
> +        */
> +       status = dma_cookie_status(&chan->chan, cookie, NULL);
> +       if (status = DMA_COMPLETE)
> +               return 0;
> +
>         /*
>          * If the cookie doesn't correspond to the currently running transfer
>          * then the descriptor hasn't been processed yet, and the residue is
>          * equal to the full descriptor size.
>          */
> -       if (cookie != desc->async_tx.cookie)
> -               return desc->size;
> +       if (cookie != desc->async_tx.cookie) {
> +               list_for_each_entry(desc, &chan->desc.pending, node) {
> +                       if (cookie = desc->async_tx.cookie)
> +                               return desc->size;
> +               }

The descriptor may be either on the pending or active list, so I had to add

+               list_for_each_entry(desc, &chan->desc.active, node) {
+                       if (cookie = desc->async_tx.cookie)
+                               return desc->size;
+               }

After that it seems to work fine. Will do more testing...

> +
> +               /*
> +                * No descriptor found for the cookie, there's thus no residue.
> +                * This shouldn't happen if the calling driver passes a correct
> +                * cookie value.
> +                */
> +               WARN(1, "No descriptor for cookie!");
> +               return 0;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
