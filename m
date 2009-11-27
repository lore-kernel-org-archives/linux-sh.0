From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 27 Nov 2009 19:47:08 +0000
Subject: Re: [PATCH] mfd: Add power control platform data to SDHI driver
Message-Id: <20091127194707.GB16866@sortiz.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Nov 27, 2009 at 01:31:27PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch adds platform data with a function for power
> control to the SDHI driver. The idea is that board specific
> code can provide their own functions so power can be enabled
> and disabled for the sd-cards.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Needed by the Ecovec board.
>  Apply on top of the SDHI driver in the SuperH tree.
I wasnt cc'ed on that driver, right ? Just checking I didnt forget it...

Cheers,
Samuel.


>  drivers/mfd/sh_mobile_sdhi.c       |   11 +++++++++++
>  include/linux/mfd/sh_mobile_sdhi.h |    8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> --- 0001/drivers/mfd/sh_mobile_sdhi.c
> +++ work/drivers/mfd/sh_mobile_sdhi.c	2009-11-27 13:14:24.000000000 +0900
> @@ -24,6 +24,7 @@
>  
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/tmio.h>
> +#include <linux/mfd/sh_mobile_sdhi.h>
>  
>  struct sh_mobile_sdhi {
>  	struct clk *clk;
> @@ -50,6 +51,15 @@ static struct mfd_cell sh_mobile_sdhi_ce
>  	.resources     = sh_mobile_sdhi_resources,
>  };
>  
> +static void sh_mobile_sdhi_set_pwr(struct platform_device *tmio, int state)
> +{
> +	struct platform_device *pdev = to_platform_device(tmio->dev.parent);
> +	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
> +
> +	if (p && p->set_pwr)
> +		p->set_pwr(pdev, state);
> +}
> +
>  static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
>  {
>  	struct sh_mobile_sdhi *priv;
> @@ -87,6 +97,7 @@ static int __init sh_mobile_sdhi_probe(s
>  
>  	/* FIXME: silly const unsigned int hclk */
>  	*(unsigned int *)&priv->mmc_data.hclk = clk_get_rate(priv->clk);
> +	priv->mmc_data.set_pwr = sh_mobile_sdhi_set_pwr;
>  
>  	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
>  	priv->cell_mmc.driver_data = &priv->mmc_data;
> --- /dev/null
> +++ work/include/linux/mfd/sh_mobile_sdhi.h	2009-11-27 13:10:34.000000000 +0900
> @@ -0,0 +1,8 @@
> +#ifndef __SH_MOBILE_SDHI_H__
> +#define __SH_MOBILE_SDHI_H__
> +
> +struct sh_mobile_sdhi_info {
> +	void (*set_pwr)(struct platform_device *pdev, int state);
> +};
> +
> +#endif /* __SH_MOBILE_SDHI_H__ */

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
