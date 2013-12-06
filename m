From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 06 Dec 2013 10:07:43 +0000
Subject: Re: [PATCH 2/2] ASoC: sh: rcar: Depend on ARCH_SHMOBILE_LEGACY
Message-Id: <1682501.71qI5yTem5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1384000429-3590-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384000429-3590-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org

Hi Morimoto-san,

What's your opinion about this patch ? It needs to be applied on top of 
"[PATCH 1/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY" which has been 
queued by Simon.

On Saturday 09 November 2013 13:33:49 Laurent Pinchart wrote:
> The driver doesn't compile on multiplatform kernels as it requires
> <mach/clock.h>.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  sound/soc/sh/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
> index 56d8ff6..ce7cfd6 100644
> --- a/sound/soc/sh/Kconfig
> +++ b/sound/soc/sh/Kconfig
> @@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
> 
>  config SND_SOC_RCAR
>  	tristate "R-Car series SRU/SCU/SSIU/SSI support"
> +	depends on ARCH_SHMOBILE_LEGACY
>  	select SND_SIMPLE_CARD
>  	select RCAR_CLK_ADG
>  	help

-- 
Regards,

Laurent Pinchart

