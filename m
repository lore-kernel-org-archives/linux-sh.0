From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 May 2014 13:25:58 +0000
Subject: Re: [PATCH 1/3] mmc: block: add block number limitation flag for lultiple block read
Message-Id: <538886E6.4000209@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com> <87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

On 05/30/2014 02:40 PM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> In some controllers, when performing a multiple block read of

    You've typoed in the subject: "lultiple".

> one or two blocks, depending on the timing with which the
> response register is read, the response value may not
> be read properly.
> Use single block read for this HW bug

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/card/block.c |   19 +++++++++++++++++--
>   include/linux/mmc/host.h |    3 +++
>   2 files changed, 20 insertions(+), 2 deletions(-)

> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..f3cbe37 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1400,8 +1400,23 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>
>   		/* Some controllers can't do multiblock reads due to hw bugs */
>   		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
> -		    rq_data_dir(req) = READ)
> -			brq->data.blocks = 1;
> +		    rq_data_dir(req) = READ) {
> +
> +			if (card->host->caps2 & MMC_CAP2_2BLKS_LIMIT) {
> +				/*
> +				 * In some controllers, when performing a
> +				 * multiple block read of one or two blocks,
> +				 * depending on the timing with which the
> +				 * response register is read, the response
> +				 * value may not be read properly.
> +				 * Use single block read for this HW bug
> +				 */
> +				if (brq->data.blocks = 2)
> +					brq->data.blocks = 1;

    I don't understand: previous code set 'brq->data.blocks' to 1 in any case 
without your extra flag. Why there's a need to set it specifically for 2 
blocks (and not set for a larger # of blocks)? This looks like an optimization 
of some sort, not a workaround?..

> +			} else {
> +				brq->data.blocks = 1;
> +			}
> +		}
>   	}
>
>   	if (brq->data.blocks > 1 || do_rel_wr) {

WBR, Sergei

