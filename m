From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:14:04 +0000
Subject: Re: [PATCH v3 22/81] ARM: shmobile: Select PINCTRL
Message-Id: <20121218021404.GE28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:50:56PM +0100, Laurent Pinchart wrote:
> The pin control framework is required by mach-shmobile. Select it in
> Kconfig.
> 
> This will be required when the sh-pfc driver will move to
> drivers/pinctrl/.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8c83d98..e02cbef 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -701,6 +701,7 @@ config ARCH_SHMOBILE
>  	select MULTI_IRQ_HANDLER
>  	select NEED_MACH_MEMORY_H
>  	select NO_IOPORT
> +	select PINCTRL
>  	select PM_GENERIC_DOMAINS if PM
>  	select SPARSE_IRQ
>  	help
> -- 
> 1.7.8.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
