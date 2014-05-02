From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 May 2014 02:38:47 +0000
Subject: Re: [PATCH 2/8] sh, irq: Remove irq_reserve_irq calling
Message-Id: <20140502023847.GI2265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398986302-30455-1-git-send-email-yinghai@kernel.org>
 <1398986302-30455-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1398986302-30455-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Thu, May 01, 2014 at 04:18:16PM -0700, Yinghai Lu wrote:
> in sh calling path:
> 	register_intc_controller
> 		=> irq_create_identity_mapping/irq_create_strict_mappins
> 			=>irq_alloc_desc: it will set bits on allocate_irq
> 		=> intc_register_irq
> 			=> irq_reserve_irq: set bits again
> 
> so we can kill this irq_reserve_irq calling.

Thanks, this looks fine to me.

As the file in question has not been updated in well over a year
and I'm not aware of any other outstanding updates to it I think
that the chance of conflicts is low. With that in mind I'm happy
for whoever takes the reset of this series to take this patch too.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-sh@vger.kernel.org
> ---
>  drivers/sh/intc/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index 8f32a13..05118f92 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -81,11 +81,8 @@ static void __init intc_register_irq(struct intc_desc *desc,
>  	unsigned long flags;
>  
>  	/*
> -	 * Register the IRQ position with the global IRQ map, then insert
> -	 * it in to the radix tree.
> +	 * insert it in to the radix tree.
>  	 */
> -	irq_reserve_irq(irq);
> -
>  	raw_spin_lock_irqsave(&intc_big_lock, flags);
>  	radix_tree_insert(&d->tree, enum_id, intc_irq_xlate_get(irq));
>  	raw_spin_unlock_irqrestore(&intc_big_lock, flags);
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
