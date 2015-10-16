From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 16 Oct 2015 13:32:20 +0000
Subject: Re: [PATCH v3 6/6] dma: rcar-dma: Fixed active descriptor initializing
Message-Id: <2206928.jRZd2TikQZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Hamza,

Thank you for the patch.

On Tuesday 29 September 2015 22:44:48 hamzahfrq.sub@gmail.com wrote:
> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
> 
> Running descriptor pointer is set to NULL upon freeing resources. Other-
> wise, rcar_dmac_issue_pending might not start new transfers
> 
> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 6eec878..db97f7b 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1042,6 +1042,7 @@ static void rcar_dmac_free_chan_resources(struct
> dma_chan *chan) list_splice_init(&rchan->desc.active, &list);
>  	list_splice_init(&rchan->desc.done, &list);
>  	list_splice_init(&rchan->desc.wait, &list);
> +	rchan->desc.running = NULL;

This looks good to me, but I wonder if it would make sense to replace the 
list_splice_init() calls with a call to rcar_dmac_chan_reinit() which sets 
desc.running to NULL, and then just process the free list below. Any opinion ?

In the meantime I'll apply your patch to my tree as it's clearly a bug fix and 
will send a pull request.

>  	list_for_each_entry(desc, &list, node)
>  		rcar_dmac_realloc_hwdesc(rchan, desc, 0);

-- 
Regards,

Laurent Pinchart

