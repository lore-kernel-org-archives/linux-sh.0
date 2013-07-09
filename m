From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 06:09:07 +0000
Subject: Re: [PATCH v3 5/7] mmc: SDHI: add DT compatibility strings for further SoCs
Message-Id: <878v1gtgcg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-1-git-send-email-g.liakhovetski@gmx.de>
	<1373298887-9877-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>


Hi Guennadi

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index cc4c872..b58c1a9 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -130,6 +130,9 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>  	{ .compatible = "renesas,shmobile-sdhi" },
>  	{ .compatible = "renesas,sh7372-sdhi" },
>  	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> +	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> +	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
> +	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
>  	{},

According to HW people, latest Renesas chip needs "TMIO_MMC_HAS_IDLE_WAIT".
Could you plase add r8a7778 / r8a7779 here ?

# or we can use common compatible name for it ?

Best regards
---
Kuninori Morimoto
