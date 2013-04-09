From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 07:54:23 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: add CN9 SCIF/RCAN selection dipswitch explanation
Message-Id: <20130409075422.GI11444@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5cs9otn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5cs9otn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 08, 2013 at 11:54:16PM -0700, Kuninori Morimoto wrote:
> Debug serial (= SCIF0) is connected to CN9 upper side,
> and it is shared by RCAN.
> This patch adds SCIF/RCAN dipswitch explanation on
> comment area for developers.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued-up in the bockw-branch.

> ---
>  arch/arm/mach-shmobile/board-bockw.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index dac4365..0275d14 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -26,6 +26,14 @@
>  #include <mach/r8a7778.h>
>  #include <asm/mach/arch.h>
>  
> +/*
> + *	CN9(Upper side) SCIF/RCAN selection
> + *
> + *		1,4	3,6
> + * SW40		SCIF	RCAN
> + * SW41		SCIF	RCAN
> + */
> +
>  static struct smsc911x_platform_config smsc911x_data = {
>  	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
>  	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
