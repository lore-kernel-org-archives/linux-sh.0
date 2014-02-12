From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Feb 2014 18:40:32 +0000
Subject: Re: [PATCH 3/5] shdma: initial of common code
Message-Id: <52FBCE2D.3030404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392227964-7088-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392227964-7088-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/12/2014 08:59 PM, Ben Dooks wrote:

    My review is quite superficial at this point.

> This is an initial helper to go with the shdma-of code
> to allow binding of devices via fdt and extraction of
> information aobut the system's DMA setup from the DT
> for the shdmac code and possibly other code to use.

> Still to be decided:

> - should arm speciifc shdma-of.c additions be in an shdma-of-arm.c file?

    Why? I don't expect SH to be ever converted to DT.

> - do we want to be able ot bind a single dma engine w/o shdma-mux code?

    No sign off again.

[...]

> diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
> index 06473a0..6475172 100644
> --- a/drivers/dma/sh/shdma-of.c
> +++ b/drivers/dma/sh/shdma-of.c
> @@ -9,6 +9,9 @@
>    * published by the Free Software Foundation.
>    */
>
> +#define DEBUG

    Hm... temporary?

[...]
> @@ -26,6 +57,8 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>   	dma_cap_mask_t mask;
>   	struct dma_chan *chan;
>
> +	pr_info("xlate id %02x\n", id);
> +

    Forgotten debug printk()?

>   	if (dma_spec->args_count != 1)
>   		return NULL;
>
> @@ -40,6 +73,111 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>   	return chan;
>   }
>
> +const struct sh_dmae_pdata *
> +sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
> +{
[...]
> +	/* look in current, or parent node for the slave mappings */
> +	prop = of_find_property(np, "renesas,slaves", &len);
> +	if (!prop)
> +		prop = of_find_property(np->parent, "renesas,slaves", &len);
> +

     Empty line not needed.

> +	if (prop) {
> +		struct sh_dmae_slave_config *slaves;
> +		int nr_slaves = len / (sizeof(u32) * 3);
> +		const __be32 *of_ptr;
> +		u32 of_idx;
> +
> +		slaves = devm_kzalloc(dev, sizeof(*slaves) * nr_slaves,
> +				      GFP_KERNEL);
> +		if (!slaves) {
> +			dev_err(dev, "cannot allocate %d slaves\n", nr_slaves);
> +			return NULL;
> +		}
> +
> +		pdata->slave = slaves;
> +		pdata->slave_num = nr_slaves;
> +		of_idx = 0;
> +		of_ptr = NULL;
> +
> +		dev_dbg(dev, "building %d slaves\n", nr_slaves);
> +
> +		for (; nr_slaves > 0; nr_slaves--, slaves++) {
> +			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
> +			slaves->mid_rid = be32_to_cpu(*of_ptr);
> +			slaves->slave_id = slaves->mid_rid;
> +
> +			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
> +			slaves->chcr = be32_to_cpu(*of_ptr);
> +
> +			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
> +			slaves->addr = be32_to_cpu(*of_ptr) ;
> +
> +			dev_dbg(dev, "slave: id %02x, chcr %08x, addr %08x\n",
> +				slaves->mid_rid, slaves->chcr, slaves->addr);
> +		}
> +	} else
> +		dev_warn(dev, "did not find any slave information\n");

    Need {} as well in *else* arm. See Documentation/CodingStyle.

> diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
> index 758a57b..4a6779f 100644
> --- a/drivers/dma/sh/shdma.h
> +++ b/drivers/dma/sh/shdma.h
> @@ -56,6 +56,24 @@ struct sh_dmae_desc {
>   	struct shdma_desc shdma_desc;
>   };
>
> +/* template information for building shdma data, provided as part of the

     The preferred multi-line comment style outside networking is:

/*
  * bla
  * bla
  */

WBR, Sergei

