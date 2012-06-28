From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Jun 2012 09:05:57 +0000
Subject: Re: [PATCH 01/13 v2] sh: ecovec: switch MMC power control to regulators
Message-Id: <20120628090557.GA28162@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1340751009-18663-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340751009-18663-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 12:49:57AM +0200, Guennadi Liakhovetski wrote:
> Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
> which makes it possible to use the fixed voltage regulator driver to switch
> card power on and off.
> 
[snip]

>  #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
>  /* SH_MMCIF */
> -static void mmcif_set_pwr(struct platform_device *pdev, int state)
> -{
> -	gpio_set_value(GPIO_PTB7, state);
> -}
> -
>  static struct resource sh_mmcif_resources[] = {
>  	[0] = {
>  		.name	= "SH_MMCIF",
> @@ -924,7 +1011,7 @@ static struct resource sh_mmcif_resources[] = {
>  };
>  
>  static struct sh_mmcif_plat_data sh_mmcif_plat = {
> -	.set_pwr	= mmcif_set_pwr,
> +	.set_pwr	= cn12_set_pwr,
>  	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
>  	.caps		= MMC_CAP_4_BIT_DATA |
>  			  MMC_CAP_8_BIT_DATA |

This doesn't match what is in the tree, so I have no idea what tree you
are working on. It fails to apply because of the down_pwr thing upstream
which doesn't exist in your patchset, and I'm certainly not going to
track it down.

Next time you send a patch series, make sure it actually applies to the
dependencies that you have written out, instead of some hypothetical tree
combination that needs to be reverse engineered.

The rest are applied. At least now you can go back and make those changes
to the patch while figuring out what tree you're working on.
