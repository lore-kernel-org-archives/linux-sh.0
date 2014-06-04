From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Jun 2014 17:29:02 +0000
Subject: Re: [PATCH 1/8] shdma: fdt: allow moving of the shdma_slave_used fields
Message-Id: <538F575E.3020802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 06/04/2014 08:14 PM, Ben Dooks wrote:

> The shdma_slave_used is used to track the DMA hardware channels that are
> claimed by clients. This works when the system has a global number space
> as used by the platform clients, however when we are using fdt possible
> space is much bigger (if we used phandle+hwid).

> It is much easier for the OF case to change to using the hwid of the
> channel and make the allocation bitmap part of the mux device that holds
> all the dma controllers that can access the set of hwids that need
> protecting. So change the code to make it that each sdev points to an
> bitmap that can be allocated via the shdma-of.c when needed.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/dma/sh/shdma-base.c | 17 +++++++++--------
>   include/linux/shdma-base.h  |  1 +
>   2 files changed, 10 insertions(+), 8 deletions(-)

> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index b35007e..5b18c88 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
[...]
> @@ -997,9 +998,9 @@ EXPORT_SYMBOL(shdma_cleanup);
>
>   static int __init shdma_enter(void)
>   {
> -	shdma_slave_used = kzalloc(DIV_ROUND_UP(slave_num, BITS_PER_LONG) *
> +	shdma_global_slave_used = kzalloc(DIV_ROUND_UP(slave_num, BITS_PER_LONG) *
>   				    sizeof(long), GFP_KERNEL);

    kcalloc() seems more fitting here.

> -	if (!shdma_slave_used)
> +	if (!shdma_global_slave_used)
>   		return -ENOMEM;
>   	return 0;
>   }

WBR, Sergei

