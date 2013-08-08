From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Aug 2013 00:12:01 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a7779: Add DU support
Message-Id: <87mwott510.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> Add a function to register the DU device with board-specific platform
> data. The DU device is named rcar-du-r8a7779, fix the clock entry
> accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
(snip)
> @@ -31,6 +32,7 @@ extern void r8a7779_earlytimer_init(void);
>  extern void r8a7779_add_early_devices(void);
>  extern void r8a7779_add_standard_devices(void);
>  extern void r8a7779_add_standard_devices_dt(void);
> +extern void r8a7779_add_du_device(struct rcar_du_platform_data *pdata);
>  extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
>  extern void r8a7779_init_late(void);
>  extern void r8a7779_clock_init(void);
(snip)
> +void __init r8a7779_add_du_device(struct rcar_du_platform_data *pdata)
> +{
> +	struct platform_device_info info = {
> +		.name = "rcar-du-r8a7779",
> +		.id = -1,
> +		.res = du_resources,
> +		.num_res = ARRAY_SIZE(du_resources),
> +		.data = pdata,
> +		.size_data = sizeof(*pdata),
> +		.dma_mask = DMA_BIT_MASK(32),
> +	};
> +
> +	platform_device_register_full(&info);
> +}

Thank you for your patch.
But, now, we don't use above style of driver registration
which goes back and forth between setup.c and board.c. 
(sh_eth is exceptional case now)

Please check below on SH-ARM ML
[PATCH 0/11] ARM: shmobile: setup cleanup / r8a7778 update

then, please call register function on board.c directly
if it needs platform data

Best regards
---
Kuninori Morimoto
