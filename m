From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 14 Nov 2013 14:03:50 +0000
Subject: Re: [PATCH 11/17] mmc: SDHI: add SoC specific workaround via HW version
Message-Id: <5284D846.60404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>	<8761rvz37d.wl%kuninori.morimoto.gx@renesas.com> <871u2jz33t.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u2jz33t.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hello.

On 14-11-2013 14:31, Kuninori Morimoto wrote:

> One of Renesas SDHI chip needs workaround to use it,
> and, we can judge it based on chip version.
> This patch adds very quick-hack workaround method,
> since we still don't know how many chips
> need workaround in the future.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/host/sh_mobile_sdhi.c |   11 +++++++++++
>   include/linux/mmc/tmio.h          |    1 +
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index f1e35a7..d241d86 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -33,6 +33,8 @@
>
>   #include "tmio_mmc.h"
>
> +#define EXT_ACC           0xe4
> +

    Why not #define it in the tmio.h? It already contains SDHI specific 
register, CTL_DMA_ENABLE...

[...]
> diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
> index a1c1f32..84d9053 100644
> --- a/include/linux/mmc/tmio.h
> +++ b/include/linux/mmc/tmio.h
> @@ -33,6 +33,7 @@
>   #define CTL_SDIO_IRQ_MASK 0x38
>   #define CTL_DMA_ENABLE 0xd8
>   #define CTL_RESET_SD 0xe0
> +#define CTL_VERSION 0xe2
>   #define CTL_SDIO_REGS 0x100
>   #define CTL_CLK_AND_WAIT_CTL 0x138
>   #define CTL_RESET_SDIO 0x1e0

WBR, Sergei

