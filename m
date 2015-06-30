From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 30 Jun 2015 16:04:06 +0000
Subject: Re: [PATCH] of/irq: Rename "intc_desc" to "of_intc_desc" to fix OF on sh
Message-Id: <20150630160406.7105EC405A7@trevor.secretlab.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <1435322565-18798-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435322565-18798-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt@kernel.org>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-next@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Fri, 26 Jun 2015 14:42:45 +0200
, Geert Uytterhoeven <geert+renesas@glider.be>
 wrote:
> Now CONFIG_OF can be enabled on sh:
> 
>     drivers/of/irq.c:472:8: error: redefinition of 'struct intc_desc'
>     include/linux/sh_intc.h:109:8: note: originally defined here
> 
> As "intc_desc" is used all over the place in sh platform code, while
> drivers/of/irq.c has a local definition used in a single function,
> rename the latter by prefixing it with "of_".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

g.

> ---
> sh-allmodconfig in next-20150626
> http://kisskb.ellerman.id.au/kisskb/buildresult/12450810/
> ---
>  drivers/of/irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 1a7980692f254c69..f6794aafa9925af2 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -469,7 +469,7 @@ int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
>  }
>  EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
>  
> -struct intc_desc {
> +struct of_intc_desc {
>  	struct list_head	list;
>  	struct device_node	*dev;
>  	struct device_node	*interrupt_parent;
> @@ -485,7 +485,7 @@ struct intc_desc {
>  void __init of_irq_init(const struct of_device_id *matches)
>  {
>  	struct device_node *np, *parent = NULL;
> -	struct intc_desc *desc, *temp_desc;
> +	struct of_intc_desc *desc, *temp_desc;
>  	struct list_head intc_desc_list, intc_parent_list;
>  
>  	INIT_LIST_HEAD(&intc_desc_list);
> @@ -496,7 +496,7 @@ void __init of_irq_init(const struct of_device_id *matches)
>  				!of_device_is_available(np))
>  			continue;
>  		/*
> -		 * Here, we allocate and populate an intc_desc with the node
> +		 * Here, we allocate and populate an of_intc_desc with the node
>  		 * pointer, interrupt-parent device_node etc.
>  		 */
>  		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> -- 
> 1.9.1
> 

