From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 02:16:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Don't set cpuidle driver en_core_tk_irqen field
Message-Id: <20130604021619.GR23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 29, 2013 at 09:42:29AM +0200, Laurent Pinchart wrote:
> The cpuidle_driver structure en_core_tk_irqen field has been removed.
> Don't set it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks.

Locally I have added this to the soc-r8a7740 branch and thus
queued it up for v3.11. However, as per requests from arm-soc
I intend to re-arrange my branches and it is highly likely
the patch will end up in a different location before I push it to
kernel.org.

> ---
>  arch/arm/mach-shmobile/cpuidle-r8a7740.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> Simon,
> 
> Most of the latest branches in your tree fail to compile when cpuidle and
> r8a7740 are enabled. This patch fixes the problem.
> 
> diff --git a/arch/arm/mach-shmobile/cpuidle-r8a7740.c b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
> index 48c7a6c..8990de2 100644
> --- a/arch/arm/mach-shmobile/cpuidle-r8a7740.c
> +++ b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
> @@ -31,7 +31,6 @@ static int r8a7740_enter_a3sm_pll_off(struct cpuidle_device *dev,
>  static struct cpuidle_driver r8a7740_cpuidle_driver = {
>  	.name			= "r8a7740_cpuidle",
>  	.owner			= THIS_MODULE,
> -	.en_core_tk_irqen	= 1,
>  	.state_count		= 3,
>  	.safe_state_index	= 0, /* C1 */
>  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> -- 
> Regards,
> 
> Laurent Pinchart
> 
